% Define the radius of the circle
radius = 10;

% Define the step size for point placement (larger step_size for spacing)
step_size = 0.5;  % Adjust this value to control point spacing

% Generate uniformly spaced points within the circle
x = -radius:step_size:radius;
y = -radius:step_size:radius;

% Create a meshgrid of x and y coordinates
[X, Y] = meshgrid(x, y);

% Calculate the distance of each point from the origin (0, 0)
distances = sqrt(X.^2 + Y.^2);

% Create a logical mask to exclude points outside the circle
outside_circle = distances > radius;

% Create a logical mask to include points within the circle
inside_circle = distances <= radius;

% Extract the x and y coordinates of points within the circle
x_inside = X(inside_circle);
y_inside = Y(inside_circle);

% Randomly select a point to circle in red within the circle
random_index = randi([1, numel(x_inside)]);
red_x = x_inside(random_index);
red_y = y_inside(random_index);

% Define the hotspot radius
hotspot_radius = 1.5;  % Adjust this value as needed

% Create a logical mask to identify points within the hotspot
hotspot_mask = (X(inside_circle) - red_x).^2 + (Y(inside_circle) - red_y).^2 <= hotspot_radius^2;

% Create a scatter plot of points within the circle (smaller and black)
scatter(x_inside, y_inside, 10, 'k', 'filled');  % Smaller black points

% Set axis equal to maintain a circular aspect ratio
axis equal;

% Create a circle to outline the circular region
th = linspace(0, 2 * pi, 100);
cx = radius * cos(th);
cy = radius * sin(th);

hold on;

% Circle the randomly selected point in red within the circle
scatter(red_x, red_y, 50, 'r', 'filled');  % Larger red point

% Circle the surrounding points in red within the hotspot map
surrounding_points = find(hotspot_mask);
scatter(x_inside(surrounding_points), y_inside(surrounding_points), 50, 'r', 'filled');  % Red points

% Plot the black circle to outline the circular region
plot(cx, cy, 'k');

title('Visualize Direction Using Null Steering');
xlabel('Horizontal Plane (m)');
ylabel('Vertical Plane (m)');

hold off;

% Create a matrix of 1s and 0s to represent the highlighted and empty values
matrix = zeros(size(x_inside));
matrix(hotspot_mask) = 1;

% Create an index array
index_array = (1:numel(matrix))';

% Combine the index and matrix into a two-column matrix
data = [index_array matrix];

% Save the data to a CSV file
csvwrite('direction.csv', data);
