function f_ana_single(fig, t_low, t_upp, x_lim, y_lim, file_path)

%--------------------now given in function call-----------------------
%{
Example: f_ana_single(1, 300, 1600, [0, 500], [0,200]);
this calls the function with the same values as written from line 8-12:

t_low = 300; %lowest setting has to be 1
t_upp = 1600; %milliseconds
y_lim = [0, 200]; %set limits for the axis of the frequency plot
x_lim =[0, 500];
fig = 1;
%}

%Get path to file
file= file_path;
%file=input('Enter "FOLDER/FILE", e.g. responder/bla --> ','s');
op=strcat(file,'.wav');
this_dir = dir();
path=strcat(this_dir(1).name,'/data/',op);

%pull data and create time-index
[data, fs]=audioread(path);
ts=(0:1/fs:(length(data)-1)/fs);

%ts2=(t_low/1000:1/fs:t_upp/1000);
data2=(data((t_low/1000)*fs:(t_upp/1000)*fs,:));

%
%Create Fourier transform of signal and frequency-index
data_fft = abs(fft(data2));
n=length(data2)-1;
f=0:fs/n:fs;

%---------------------plotting section--------------------------
%---enter figure(some_number) into command window to keep old plot
%--------------------
figure(fig);
subplot(2,1,1);
plot(ts, data);
title(file);
xlabel('time [s]');
ylabel('amplitude');

subplot(2,1,2);
fft_plot = strcat(file, '-fft'); %create plot title
plot(f, data_fft);
ylim(y_lim);
xlim(x_lim);
title(fft_plot);
labelx = strcat('frequency [Hz], from ' ,num2str(t_low), ' ms to ', num2str(t_upp), ' ms');
xlabel(labelx);
ylabel('amplitude');
    %}
end