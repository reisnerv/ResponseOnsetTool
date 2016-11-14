disp('This is Davids playground setup');
set_parameters;


filepath = './data/non_breathy_data/responder/momap_main_124_1_6_16.wav';
[pathstr, name, ext] = fileparts(filepath);
C= strsplit(name, '_');




%{
t_low = 1;
t_upp = 1800;
%Check filepath for response...

[wav, fs]=audioread('./data/non_breathy_data/responder/momap_main_124_1_6_16.wav');

data = abs(wav(:,1)+wav(:,2));
data2=(data((t_low/1000)*fs:(t_upp/1000)*fs,:));
ts_data = (0:1/fs:(length(data)-1)/fs);
ts_data2 = (0:1/fs:(length(data2)-1)/fs);


%Create Fourier transform of signal and frequency-index
data_fft = abs(fft(data));
n=length(data)-1;
f=0:fs/n:fs;

data2_fft = abs(fft(data2));
n=length(data2)-1;
f2=0:fs/n:fs;
%}


%mTextBox = uicontrol('style','text');
%set(mTextBox,'String','Hello World');