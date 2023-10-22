% Constants
speedOfSound = 343;  % Speed of sound in meters per second
initialDistance = 72; % Initial distance between the human and the object
walkingSpeed = 1.5; % Average walking speed of the human in meters per second
velocityHuman = walkingSpeed; % Average velocity (positive value)

% Time and position parameters
t = 0:0.1:5; % Time from 0 to 5 seconds with a 0.1 second interval

% Initialize a random walk for distance with added noise
deltaDistance = zeros(size(t));
for i = 2:length(t)
    % Introduce some noise to the delta distance
    deltaDistance(i) = randn() * walkingSpeed * 0.1 + 0.05 * randn();
end

% Introduce an outlier for a limited duration
outlier_start = 2;  % Start time of the outlier in seconds
outlier_duration = 1;  % Duration of the outlier in seconds
outlier_distance = 70;  % Outlier distance in meters

for i = find(t >= outlier_start & t < (outlier_start + outlier_duration))
    deltaDistance(i) = outlier_distance - initialDistance;
end

position = initialDistance - cumsum(deltaDistance);

% Doppler shift calculation
f0 = 24e9; % Transmit frequency in Hz
dopplerShift = zeros(size(t));
for i = 1:length(t)
    dopplerShift(i) = (f0 * (speedOfSound + velocityHuman)) / (speedOfSound - velocityHuman);
end

% Plot the graph
figure;
plot(t, position);
xlabel('Time (s)');
ylabel('Distance (cm)');
title('Scanning Sidewalk');
grid on;

% Save the data to a CSV file
data = [t' position'];
csvwrite('edge.csv', data);
