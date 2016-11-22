% Plot the x and y positions of the pendulum
function res = pendulumSim()
    % Start conditions
    g = 9.8;           % m/s^2, acceleration due to gravity
    length = 4;        % m, rest length of the pendulum
    startAngle = pi/2; % Initial starting angle
    startOmega = 0;    % Start with no speed

    % Call ode45
    [t, result] = ode45(@movePendulum, [0, 50], [startAngle, startOmega]);
    result1 = result(:,1);
    result2 = result(:,2);

    % Convert from circular to cartesian
    x = length*sin(result1);
    y = length*cos(result2);
    
    % Plot the points
    hold on
    xlabel('Horizontal Displacement');
    ylabel('Vertical Displacement');
    title('Horizontal and Vertical Displacement')
    comet(x,y)
    
    % Update equations of motion
     function res = movePendulum(~, CurrentValues)
         
         % Unpack the vector
         % Theta, indicating distance traveled from start (analogous to
         % displacement)
         theta = CurrentValues(1);
         
         % Omega, derivaptive of theta (analogous to velocity)
         omega = CurrentValues(2);

         % Pendulum motion equation (analogous to translational
         % acceleration)
         angularAcceleration = -g/length * sin(theta);
         
         % Return the results, keep in mind ode45 will intergrate
         res = [omega; angularAcceleration];
    end 
end