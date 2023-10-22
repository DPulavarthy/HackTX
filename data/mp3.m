% Read the MP3 file
[audio_data, sample_rate] = audioread('combined.mp3');

% Calculate the waveform
waveform = audio_data(:, 1);

% Denoise the waveform
% Use a median filter to remove high-frequency noise
denoised_waveform = medfilt1(waveform, 5);

% Find the max amplitude and map it to distance
max_amplitude = max(denoised_waveform);
dvt = interp1([0, max_amplitude], [10, 0], denoised_waveform);

% Plot the waveform and the denoised waveform
figure;
subplot(2,1,1); % Subplot for the original amplitude graph
plot(denoised_waveform);
title('Original Waveform');
ylabel('Amplitude (m)');
xlabel('Time (s)');

% Segment data into one-second intervals and find min values
samples_per_second = sample_rate;
num_seconds = floor(length(denoised_waveform) / samples_per_second);
min_values = zeros(1, num_seconds);
time_vector_sec = 1:num_seconds;
denoised_waveform_sec = zeros(1, num_seconds);

for i = 1:num_seconds
    start_idx = (i-1) * samples_per_second + 1;
    end_idx = i * samples_per_second;
    min_values(i) = min(dvt(start_idx:end_idx));
    denoised_waveform_sec(i) = mean(denoised_waveform(start_idx:end_idx));
end

% Subplot for the distance vs time graph
subplot(2,1,2); 
plot(time_vector_sec, min_values);
title('Distance vs Time Graph');
ylabel('Distance (m)');
xlabel('Time (s)');

% Save the matrices to a CSV file
output_matrix = [time_vector_sec', denoised_waveform_sec', min_values'];
csvwrite('output.csv', output_matrix);