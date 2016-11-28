% Update all the equations of motion
% (velocity and acceleration in x and y)
% Takes in all these values from previous timestep to update
function res = movePendulum(~, CurrentValues)

% Define given terms
m = 1; % kg
g = 9.8;   % m/s^2
%k = 1000000000;   % Spring constant
l = 1;     % rest length

% Get current values
x = CurrentValues(1);
y = CurrentValues(2);
vx = CurrentValues(3);
vy = CurrentValues(4);

diagonalDistance = sqrt(x^2 + y^2);

% Get forces in each directions (with drag)
ForceInX = m*g*sin(y/x) %-k*(diagonalDistance - l)*(x/diagonalDistance);
ForceInY = m*g * cos(y/x) %- k*(diagonalDistance - l)*(y/diagonalDistance);

% Acceleration 
ax = ForceInX./m;
ay = ForceInY./m;

% keep in mind ode45 will intergrate
res = [vx; vy; ax; ay];
end