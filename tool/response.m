function [response, onset, m, avpeak, ratio, mpeak_w, mean_data] = response(file, fig, filename)
set_parameters;
figure(fig);
%assume negative case
response = 0;
onset = 0.0;

%Pull data for individual file
[wav, fs]=audioread(file);

%Preprocessing
data = abs(((wav(:,1)+ wav(:,2))/2))*scaling_factor;

%Smooth the data
smoothedData = smooth(data, sm_factor);

[pks,locs] = findpeaks(smoothedData(round((t_low/1000)*fs):length(smoothedData),:));


[m, i] = max(pks);
avpeak = (sum(pks) - m)/(length(pks)-1);
mpeak_loc = (t_low/1000)+locs(i,:)/fs;

loop_c = 1;
position = round(mpeak_loc*fs);
mpeak_w = 0;

while (loop_c == 1)
    position = position - 10;
    if (smoothedData(position,:) < mean(smoothedData))
        mpeak_w = mpeak_loc - (position/fs);
        break;
    end
end
        
ratio = m/avpeak;

if (avpeak*max_average_ratio) < m
    if (abs(round(mpeak_loc*fs) - length(data)) > 10) %
        response = 4;
        onset = mpeak_loc - mpeak_w*peak_w_adjust;
    end
end

% Catch record errors
mean_data = mean(data);
if (mean_data < MEAN_THRESHOLD) || (m < MAXPEAK_THRESHOLD)
    response = 99;
    onset = 0;
end

% found a response, plot it against original and smoothed data, if flag set
if (PLOTS)
    ts_data = (0:1/fs:(length(data)-1)/fs);
    together = horzcat(data, smoothedData);
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
end

end