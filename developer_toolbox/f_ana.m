function f_ana(path)

%t_low = 300;
%t_upp = 1800; %milliseconds, not used right now
%Get path to file
%file=input('Enter filepath (starting from "THIS_DIRECTORY/data") like FOLDER/FILE ','s');
%op=strcat(file,'.wav');
%this_dir = dir();
%path=strcat(this_dir(1).name,'/data/',op);

%pull data and create time-index
[wav, fs]=audioread(path);
data = wav;
ts = (0:1/fs:(length(data)-1)/fs);


%Create Fourier transform of signal and frequency-index
data_fft = abs(fft(data));
n=length(data)-1;
f=0:fs/n:fs;

%---------------------plotting section--------------------------
%---enter figure(some_number) into command window to keep old plot
%--------------------
subplot(2,1,1);
plot(ts, data);
title(path);
xlabel('time [s]');
ylabel('amplitude');

subplot(2,1,2);
fft_plot = strcat(path, '-fft'); %create plot title
plot(f, data_fft);
ylim([0, 200]);
xlim([0, 500]);
title(fft_plot);
xlabel('frequency [Hz]');
ylabel('amplitude');
    
end