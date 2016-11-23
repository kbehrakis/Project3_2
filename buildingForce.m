% Plot the displacement of top of building vs time
% The sum of forces on the building: (Force Applied) - (Building
% Elasticity) - (Damping Force), see
% https://www.wired.com/2010/11/st_equation_skycraper/ 
function res = buildingForce()
    % Start conditions
    appliedForce = sin(pi/4);   % Force of earthquake, CHANGE (RESEARCH)
    buildingStiffness = 20;    % Stiffness constant of building, MUST CHANGE (RESEARCH)
    heightOfBuilding = 100;     % Height of skyscraper (m)
    massOfBuilding = 201848605; % Mass of skyscraper (kg)
    dampingConstant = 9000;     % MUST CHANGE, PROBABLY CALL TO PENDULUM FUNCTION TO FIND APPROPRIATE RATIO
    velocityStart = 0;          % Velocity at top, starts at 0
    xStart = 0;                 % Start distance without force
  
    % ode45
    startTime = 0;
    endTime = 86400; % 1 day
    parameters = [xStart, velocityStart];
    [Times, UpdatedParameters] = ode45(@moveBuilding, [startTime, endTime], parameters);
   
   % Get values
   Displacement = UpdatedParameters(:,1); 
   Velocity = UpdatedParameters(:,2);
   
   comet(Times, Displacement);
   hold on
   xlabel('Time (s)');
   ylabel('Displacement (m)');
   title('Horizontal Displacement of Top of Building')
    
    % Update equations of motion
     function res = moveBuilding(~, CurrentValues)
         
         % Unpack the vector
         % Get the current displacement
         currentX = CurrentValues(1);
         
         % Get the current velocity
         currentV = CurrentValues(2);

         % Find building elasticity force (k * x, where k = building stiffness, x = displacement)
         buildingElasticity = buildingStiffness * currentX; 

         % Find damping force (c * v, where c = damping constant, v =
         % velocity at top of building)
         dampingForce = dampingConstant * currentV;
         
         % Find the total force at top of building
         currentForce = appliedForce - buildingElasticity - dampingForce;
          
         % Find the acceleration at top of building
         currentAcceleration = currentForce/massOfBuilding; % NEED TO CHANGE MASS TO ADD IN PENDULUM MASS
         
         % Return the results, keep in mind ode45 will intergrate
         res = [currentV; currentAcceleration];
    end 
end