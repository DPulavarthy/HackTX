% Generate two waveforms
num_samples = 100;
ref_waveform = rand(1, 2000);
delay = rand(1, 20);
recv_waveform = [delay, ref_waveform];

% Calculate the cross-correlation
xcorr_data = xcorr(ref_waveform, recv_waveform, 100);

% Find the maximum cross-correlation value
max_xcorr = max(xcorr_data);

% Normalize the cross-correlation data
xcorr_data = xcorr_data / max_xcorr;

% Plot the cross-correlation data
figure;
plot(xcorr_data);

% Add a title and axis labels
title('Waveform');
xlabel('Lag');
ylabel('Correlation');

% Show the plot
grid on;

% Create a matrix with lag and correlation
lag = 0:200;  % Assuming a lag range of -100 to 100
data = [lag' xcorr_data'];

% Save the data to a CSV file with two columns
writematrix(data, 'waveform.csv');
