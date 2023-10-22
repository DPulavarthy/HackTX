% Constants
speedOfSound = 343;  % Speed of sound in meters per second
initialDistance = 10; % Initial distance between the human and the object
walkingSpeed = 1.5; % Average walking speed of the human in meters per second
velocityHuman = walkingSpeed; % Average velocity (positive value)

% Time and position parameters
t = 0:0.1:10; % Time from 0 to 10 seconds with a 0.1 second interval (fewer data points)

% Initialize a random walk for distance
deltaDistance = zeros(size(t));
for i = 2:length(t)
    deltaDistance(i) = randn() * walkingSpeed * 0.1;
end
position = initialDistance - cumsum(deltaDistance);

% Calculate the speed by taking the derivative of the position
speed = diff(position) / 0.1;  % Using numerical differentiation

% Doppler shift calculation
f0 = 24e9; % Transmit frequency in Hz
dopplerShift = zeros(size(t));
for i = 1:length(t)
    dopplerShift(i) = (f0 * (speedOfSound + velocityHuman)) / (speedOfSound - velocityHuman);
end

% Plot the graphs
figure;
subplot(2, 1, 1);
plot(t, position);
xlabel('Time (s)');
ylabel('Distance (m)');
title('Random Human Movement Towards an Object');
grid on;

subplot(2, 1, 2);
plot(t(2:end), speed);  % Plot speed with one less data point
xlabel('Time (s)');
ylabel('Speed (m/s)');
title('Speed vs. Time');
grid on;

% Save the data to a CSV file
position_data = [t' position'];
speed_data = [t(2:end)' speed'];  % Remove the first data point for speed
csvwrite('svt.csv', position_data);

% Display the estimated Doppler shift
disp(['Initial Doppler Shift: ' num2str(dopplerShift(1)) ' Hz']);
disp(['Final Doppler Shift: ' num2str(dopplerShift(end)) ' Hz']);
