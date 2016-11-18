% Plot pendulum displacement over some amount of time
% Given: speed and angle
function res = simulatePendulum(speed, angle)
   angleRadians = angle*(pi/180);
    
   % Get x and y velocities
   vx = speed*sin(angleRadians);
   vy = speed*cos(angleRadians);
   
   % Start positions
   xStart = -1;
   yStart = 0;
   
   parameters = [xStart, yStart, vx, vy];
   
   % ode45
   startTime = 0;
   endTime = 10;
   [Times, UpdatedParameters] = ode45(@movePendulum, [startTime, endTime], parameters);
   
   % Get values
   x = UpdatedParameters(:,1);
   y = UpdatedParameters(:,2);
   updatedVX = UpdatedParameters(:,3);
   updatedVY = UpdatedParameters(:,4);
   
   comet(x,y);
   hold on
   xlabel('Horizontal Displacement');
   ylabel('Vertical Displacement');
   title('Horizontal and Vertical Displacement')
end