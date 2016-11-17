% Plot the x and y positions of the pendulum
function res = pendulumAcceleration()
    % Start conditions
    g = 9.8; % m/s^2
    length = 4; % m
    startAngle = pi/2;
    startAngle2 = 0;

    xStart = 0;
    yStart = 1;

    % Equation for angular acceleration (-g/R * sin(theta))
    accelerationEquation = @(time, xPos) [xPos(2); -g/length*sin(xPos(1))];

    % Call ode45
    [t, result] = ode45(accelerationEquation, [0, 50], [startAngle, startAngle2]);
   % [t, result] = ode45(@pendulumForceOnBuilding, [0, 50]);
    result1 = result(:,1);
    result2 = result(:,2);

    x = length*sin(result1);
    y = length*cos(result2);
    plot(x,y)
end