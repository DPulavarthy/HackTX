% Constants
speedOfSound = 343;  % Speed of sound in meters per second
initialDistance = 10; % Initial distance between the human and the object
walkingSpeed = 1.5; % Average walking speed of the human in meters per second
velocityHuman = walkingSpeed; % Average velocity (positive value)

% Time and position parameters
t = 0:0.01:10; % Time from 0 to 10 seconds with a 0.01 second interval

% Initialize a random walk for distance
deltaDistance = zeros(size(t));
for i = 2:length(t)
    deltaDistance(i) = randn() * walkingSpeed * 0.01;
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
subplot(2, 1, 1);
plot(t, position);
xlabel('Time (s)');
ylabel('Distance (m)');
title('Random Human Movement Towards an Object');
grid on;


% Save the data to a CSV file
data = [t' position'];
csvwrite('dvt.csv', data);

% Display the estimated Doppler shift
disp(['Initial Doppler Shift: ' num2str(dopplerShift(1)) ' Hz']);
disp(['Final Doppler Shift: ' num2str(dopplerShift(end)) ' Hz']);