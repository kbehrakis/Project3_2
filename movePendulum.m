% Update all the equations of motion
% (velocity and acceleration in x and y)
% Takes in all these values from previous timestep to update
function res = movePendulum(~, CurrentValues)

% Define given terms
mass = 1; % kg
g = 9.8;   % m/s^2
%k = 1000000000;   % Spring constant
length = 1;     % rest length

% Get current values
x = CurrentValues(1);
y = CurrentValues(2);
vx = CurrentValues(3);
vy = CurrentValues(4);

diagonalDistance =1;% sqrt(x^2+y^2); 

speed = sqrt(vx^2+vy^2);
ac = speed^2/diagonalDistance
%angularAcceleration = (g/length) * (x/diagonalDistance); % sin(angle)

% Get translational acceleration (translationAcceleration =
% radiusOfCurvature * angularAceleration)
translationalAcceleration = g * (y/diagonalDistance);

% Acceleration 
ax =  ac *(-x/diagonalDistance)
ay =  ac *(y/diagonalDistance)-g

% keep in mind ode45 will intergrate
res = [vx; vy; ax; ay]
end