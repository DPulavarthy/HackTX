% Number of samples in the waveform
num_samples = 200;
% Number of iterations to simulate the moving object
num_iterations = 100;
% Maximum delay
max_delay = 20;
% Arrays to store the results
estimated_delays = zeros(1, num_iterations);
% Generating a reference waveform with random values
ref_waveform = rand(1, num_samples);
% Store num_iterations in a separate array
num_iterations_array = (1:num_iterations);

for iter = 1:num_iterations
    % Generating a sinusoidal delay with added randomness to emulate smoother object movement
    delay = round(max_delay/2 * (sin(2*pi*iter/num_iterations) + 1) + randi([-2, 2], 1, 1));
    delay = abs(delay);  % Ensuring the delay is non-negative
    
    % Creating the received waveform with the calculated delay
    recv_waveform = [zeros(1, delay), ref_waveform(1:end-delay)];
    
    % Cross-correlating the reference and received waveforms
    [correlation, lag] = xcorr(ref_waveform, recv_waveform);
    
    % Finding the lag value at the max correlation value
    [~, idx] = max(correlation);
    estimated_delay = lag(idx);
    
    % Storing the estimated delays
    estimated_delays(iter) = abs(estimated_delay);  % Ensuring the estimated delay is non-negative
end

% Transpose the estimated_delays array and log it into a CSV file vertically
data = [num_iterations_array', estimated_delays'];
csvwrite('waveform_multi.csv', data);

% Plotting the estimated delays
figure;
plot(estimated_delays);
title('Waveform over Iterations');
xlabel('Iteration');
ylabel('Distance (m)');
grid on;
axis tight;
