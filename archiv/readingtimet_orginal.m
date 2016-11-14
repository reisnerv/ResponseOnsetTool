function readingtimet_orginal()


filename=input('Enter Directory ','s');
op=strcat(filename,'\*.wav');
directory=dir(op);
t0=0;rt = 0; l =0;
%---------------------file handling code part 1 start----------
resultfile='\Rt_Rd_Time3.XLS';
finalresultfile=strcat(filename,resultfile);
filehandle=fopen(finalresultfile,'a');
%---------------------file handling code part 1 end-----------
ratio=1.3;
loop=1;
process=1;
% while loops work till end for each subject
while (loop==1)
   file=strcat(filename,'\',directory(process).name)
   [data fs num]=wavread(file);
   ts=[0:1/fs:length(data)/fs];
   windoe=round(fs/100); % 1/100th of second    
    while (loop==1)

        %-------------------------------------------------------
        % creting t0 
        array=1;
        %loop 1 calculates average of regions of size 1/100 second in first 0.5 sec
        for (chek=1:round(fs/100):round(fs*.3))
            region(array)=sum(abs(data(chek:round(chek+fs/100))));
            array=array+1;
        end
        start=1;

        % loop 2 finds the smallest region of the values calcualte in 1 as seed val
        for (chek=1:length(region)-1)
            if(region(chek)<region(chek+1))
                start=chek*fs/100;
            end
        end

        % loop 3 scans the windoe of size 1/100 starting from seed to find region
        % of intrest where next to next window is greater than the set ratio
        for (i=round(start):windoe:length(data)-3*windoe)
            alpha=sum(abs(data(i:i+windoe)));
            beta=sum(abs(data(i+(2*windoe):i+(3*windoe))));
            if((beta/alpha)>ratio)
                point=i+windoe;
                break;
            end
        end
        %-----
        i1=round(windoe/10);
        i2=point+(2*round(windoe*10)*10);
        % loop 4 scans the regions found in 3rd stage to pinpoint the exact point
        % by looking at 1/1000 of second.
        for(i=point:i1:i2)
           alpha=sum(abs(data(i:i+i1)));
           beta=sum(abs(data(i+2*i1:i+3*i1)));
           if ((beta/alpha)>ratio)
            finpoint=i+i1;
            t0=finpoint/fs;
            break;
           end
        end
        %------------------------------------------------------
        % if t0 found is less than 0.1 second it must be an error due to noisy
        % signal, move the ration up of 0.1 and continue from start to find it
        % again with revised ratio.
          if(t0<0.1)

               ratio=ratio+0.1;

               continue;
           else
               ratio=1.2;
               break;
           end
        %----------------------------------
    end
    ratio=1.2;
   atad=data(length(data):-1:1);
        while (loop==1)

        array=1;
        %loop 1 calculates average of regions of size 1/100 second in first 0.5 sec
        for (chek=1:round(fs/100):round(fs*.5))
            region(array)=sum(abs(atad(chek:round(chek+fs/100))));
            array=array+1;
        end
        start=1;

        % loop 2 finds the smallest region of the values calcualte in 1 as seed val
        for (chek=1:length(region)-1)
            if(region(chek)<region(chek+1))
                start=chek*fs/100;
            end
        end

        % loop 3 scans the windoe of size 1/100 starting from seed to find region
        % of intrest where next to next window is greater than the set ratio
        for (i=round(start):windoe:length(atad)-3*windoe)
            alpha=sum(abs(atad(i:i+windoe)));
            beta=sum(abs(atad(i+(2*windoe):i+(3*windoe))));
            if((beta/alpha)>ratio)
                point=i+windoe;
                break;
            end
        end
        %-----
        i1=round(windoe/10);
        i2=point+(2*round(windoe*10)*10);
        % loop 4 scans the regions found in 3rd stage to pinpoint the exact point
        % by looking at 1/1000 of second.
        for(i=point:i1:i2)
           alpha=sum(abs(atad(i:i+i1)));
           beta=sum(abs(atad(i+2*i1:i+3*i1)));
           if ((beta/alpha)>ratio)
            finpoint=i+i1;
            t2=finpoint/fs;
            break;
           end
        end
        %------------------------------------------------------
        % if t0 found is less than 0.1 second it must be an error due to noisy
        % signal, move the ration up of 0.1 and continue from start to find it
        % again with revised ratio.
          if(t2<0.4)

               ratio=ratio+0.1;

               continue;
           else
               ratio=1.2;
               break;
           end
        %----------------------------------
    end
hold off;
plot(ts(1:length(data)),data);
hold on;
line=zeros(1,round(t0*fs));
line02=zeros(1,round(t2*fs));
plot(ts(1:length(line)),line,'k');
stt2=length(data)-round(t2*fs);
t1=length(data)/fs-t0-t2
plot(ts(stt2:stt2+length(line02)-1),line02,'r');
%x=strcat(directory(process).name,',',num2str(t0),',',num2str(t1));
%xx=strcat(x,'.jpg');

rt = rt +t1;
l = l+1;
%print ('-djpeg', xx) ;

%disp(x);

%--------------------------file handling code part 2 start ------------
%fprintf(filehandle,x);
%fprintf(filehandle,'\n');
fprintf(filehandle,'%s\t  %s\t %s\t  %s\t  \n',directory(process).name,num2str(t0),num2str(t1),num2str(t2));
%-------------------------file handling code part 2 end ----------------
if(process==length(directory))
    break;
else
    process=process+1;

end

end
%------------------------ file handling code part 3 start ----------
fclose(filehandle);
%-------------------------file handling code part 3 end 