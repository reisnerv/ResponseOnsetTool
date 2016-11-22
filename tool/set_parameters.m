%These parameters will be used in all other scripts, so treat them with
%care:

%amplify the raw signal by factor of
scaling_factor = 2;

%response peak has to be x times greater than the average peak to be
%counted
max_average_ratio = 3;

%smooth data via moving average of x points
sm_factor = 1555;

%minimum distance two peaks must have to both be counted for the
%peak-finding function, in seconds: best 0.x-0.1, but this value ist not
%that important
min_peak_dis = 0.05;

%only use data starting from x, in milliseconds (1000 = one second)
t_low = 350;

%split audio files into three folders "responder", "record_error" and "non-responder", 0 or 1
split = 1;

%disable research mode to work faster (saves plots as jpg and not in
%matlab for example)
research = 0; %research mode is of for =0

%Threshold, below which the file is marked as record error
record_error_threshold = 0.0005;

%---------------------experimental parameters---------------------------

%adjusts the amount of peak width that is substracted from the position of
%the max peak to find its "beginning"
peak_w_adjust = 1;