function folder_fft_spectrum(directory)

filename = directory;
%filename=input('Enter Directory ','s');
op=strcat(filename,'\*.wav');
directory=dir(op);

loop = 1;
process = 1;
while (loop==1)
    file=strcat(filename,'/',directory(process).name);
    disp(file);
    figure(process);
    f_ana(file);
    if(process==length(directory))
        break;
    else
    process=process+1;
    end

end



end