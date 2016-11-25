function [response, onset, m, avpeak, ratio, mpeak_w, smoothedMean] = response(file, fig, filename)
set_parameters;
figure(fig);
%assume negative case
response = 0;
onset = 0.0;

%Pull data for individual file
[wav, fs]=audioread(file);

%Preprocessing
data = sum(abs(wav),2)*SCALING_FACTOR/size(wav,2);

%Smooth the data
smoothedData = smooth(data, ROLLING_AVERAGE);
smoothedMean = mean(smoothedData);

% Get peaks, their location and the maximum
[pks,locs] = findpeaks(smoothedData(round((T_LOW/1000)*fs):length(smoothedData),:));
[m, i] = max(pks);
avpeak = (sum(pks) - m)/(length(pks)-1);
mpeak_loc = (T_LOW/1000)+locs(i,:)/fs;
ratio = m/avpeak;

% Find footpoint of maxpeak
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

if (avpeak*MAX_AVERAGE_RATIO) < m
    if (abs(round(mpeak_loc*fs) - length(data)) > CUTOFF_POINT) %
        response = 4;
        onset = mpeak_loc - mpeak_w*PEAK_W_ADJUST;
    end
end

% Catch record errors
if (smoothedMean < MEAN_THRESHOLD) || (m < MAXPEAK_THRESHOLD)
    response = 99;
    onset = 0;
end

% found a response, plot it against original and smoothed data, if flag set
if (PLOTS)
    ts_data = (0:1/fs:(length(data)-1)/fs);
    plot(ts_data, horzcat(data, smoothedData));
    title(filename, 'Interpreter', 'none')
    line([onset onset], [0 max(data)], 'Color', 'k', 'Linewidth', 1);
    line([mpeak_loc mpeak_loc], [0 max(data)], 'Color','c','Linewidth', 1);
    str = horzcat('onset at ', num2str(onset));
    dim = [.15 .6 .3 .3];
    annotation('textbox',dim,'String',str,'FitBoxToText','on', 'BackgroundColor', 'w');
    xlabel('time (s)');
    ylabel('amplitude (dB)');
    grid on;
end

end
