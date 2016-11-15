%example call: folder_response('./data/responder/');

function folder_response(directory)

filename = directory;
disp(filename);
set_parameters;

%filename=input('Enter Directory ','s');
op=strcat(filename,'\*.wav');
directory=dir(op);


resultfile=strcat('\ResponseTime2.XLS');
finalresultfile=strcat(filename,resultfile);
filehandle=fopen(finalresultfile,'w');

%copy files into new folders
if (split)
   mkdir(horzcat(filename, '/responder/'));
   mkdir(horzcat(filename, '/non_responder/'));  
   mkdir(horzcat(filename, '/record_error/'));
   mkdir(horzcat(filename, '/responder/plots/'));
   mkdir(horzcat(filename, '/non_responder/plots/'));  
   mkdir(horzcat(filename, '/record_error/plots/'));
end

loop = 1;
process = 1;
while (loop==1)
    file=strcat(filename,'/',directory(process).name);
    [resp, ons] = response(file, process, directory(process).name); 
    fprintf(filehandle,'%s\t  %s\t %s\t \n',directory(process).name,num2str(resp),num2str(ons));
    if (research~=1)
        saveas(process, strcat(file, '.png'));
        close;
    end
    if (split)
       if (resp==4)
           %disp(directory(process).name);
           copyfile(file, horzcat(filename,'/responder'), 'f');
           if (research~=1)
               movefile(strcat(file, '.png'), horzcat(filename,'/responder/plots'), 'f');
           end
       end
       if (resp==0)
           copyfile(file, horzcat(filename,'/non_responder'), 'f');
           if (research~=1)
               movefile(strcat(file, '.png'), horzcat(filename,'/non_responder/plots'), 'f');
           end
       end
       if (resp==99)
           %disp(directory(process).name);
           copyfile(file, horzcat(filename,'/record_error'), 'f');
           if (research~=1)
               movefile(strcat(file, '.png'), horzcat(filename,'/record_error/plots'), 'f');
           end
       end
    end

    if(process==length(directory))
        break;
    else
    process=process+1;
    end

end

fclose(filehandle);



end