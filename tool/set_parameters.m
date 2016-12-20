%These parameters will be used in all other scripts, so treat them with
%care:

%File extension
FILE_EXTENSION = '.wav';

%amplify the raw signal by factor of
SCALING_FACTOR = 2;

%response peak has to be x times greater than the average peak to be
%counted
MAX_AVERAGE_RATIO = 3;

%smooth data via moving average of x points
ROLLING_AVERAGE = 1555;

%only use data starting from x, in milliseconds (1000 = one second)
T_LOW = 350;

%split audio files into three folders "responder", "record_error" and "non-responder", 0 or 1
SPLIT = 1;

%disable research mode to work faster (saves plots as jpg and not in
%matlab for example)
RESEARCH = 0; %research mode is of for =0

% Want plots?
PLOTS = 1;

%Threshold, below which the file is marked as record error
MEAN_THRESHOLD = 0.001; %for the mean amplitude of the file
MAXPEAK_THRESHOLD = 0.05; %for the highest peak

%any peak closer than this to the end of the file will not be counted,
%value in data points
CUTOFF_POINT = 250;

% Minimal width for the maxpeak
MIN_MAXPEAK_WIDTH = 0.015;

% Threshold for the max peak to be counted as a response
AMP_THRESHOLD = 0.25;

%---------------------experimental parameters---------------------------

%adjusts the amount of peak width that is substracted from the position of
%the max peak to find its "beginning"
PEAK_W_ADJUST = 1;
