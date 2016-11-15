% setup
fig = 1;
file = './evaluation/mistakes/record_error/momap_eeg_104_4_3_8.wav';
filename = file;
set_parameters;
figure(fig);


%assume negative case
response = 0;
onset = 0.0;

%Pull data for individual file
[wav, fs]=audioread(file);

%Preprocessing
data = abs(((wav(:,1)+ wav(:,2))/2))*scaling_factor;
ts_data = (0:1/fs:(length(data)-1)/fs);

%Smooth the data
data_sm = smooth(data, sm_factor);

data_fml = data_sm(round((t_low/1000)*fs):length(data_sm),:);
%switch the out-commented line with the in-commented line if computation takes too long
%[pks,locs,w, ~] = findpeaks(data_sm(round((t_low/1000)*fs):length(data_sm),:), 'MinPeakDistance', min_peak_dis);
[pks,locs] = findpeaks(data_fml);


[m, i] = max(pks);
avpeak = (sum(pks) - m)/(length(pks)-1);
mpeak_loc = (t_low/1000)+locs(i,:)/fs;

loop_c = 1;
position = round(mpeak_loc*fs);
mpeak_w = 0;

while (loop_c == 1)
    position = position - 10;
    if (data_sm(position,:) < mean(data_sm))
        mpeak_w = mpeak_loc - (position/fs);
        break;
    end
end
        
%mpeak_w = w(i,:)/fs;

if (avpeak*max_average_ratio) < m
    if (abs(round(mpeak_loc*fs) - length(data)) > 10) %
        response = 4;
        onset = mpeak_loc - mpeak_w*peak_w_adjust;
    end
end


%found a response, plot it against original and smoothed data:
together = horzcat(data, data_sm);
plot(ts_data, together);
title(filename, 'Interpreter', 'none')
line([onset onset], [0 max(data)], 'Color', 'k', 'Linewidth', 1);
line([mpeak_loc mpeak_loc], [0 max(data)], 'Color','c','Linewidth', 1);
str = horzcat('onset at ', num2str(onset));
dim = [.15 .6 .3 .3];
annotation('textbox',dim,'String',str,'FitBoxToText','on', 'BackgroundColor', 'w');
xlabel('time (s)');
ylabel('dB');
grid on;
%dim = [.1 .3 .3 .3];
%annotation('textbox',dim,'String',filename,'FitBoxToText','on');