% Plot the displacement of top of building vs time
% The sum of forces on the building: (Force Applied) - (Building
% Elasticity) - (Damping Force), see
% https://www.wired.com/2010/11/st_equation_skycraper/ 
function res = buildingForce()
    % Start conditions
    appliedForce = sin(pi/4);   % Force of earthquake, CHANGE (RESEARCH)
    buildingStiffness = 200;    % Stiffness constant of building, MUST CHANGE (RESEARCH)
    heightOfBuilding = 100;     % Height of skyscraper (m)
    massOfBuilding = 201848605; % Mass of skyscraper (kg)
    velocityStart = 0;          % Velocity at top, starts at 0
    xStart = 0;                 % Start distance without force
   
    % Damping coeffecient: c = zeta * (2* sqrt(mass*buildingStiffness), where 
    %                      zeta = 1, critical damping
    %                      0 < zeta < 1, underdamped 
    %                      zeta > 1, overdamped
    % https://en.wikipedia.org/wiki/Harmonic_oscillator#Example:_mass-spring-damper
    % https://www.et.byu.edu/~tom/classes/436/ClassNotes/Class20(Second-Order).pdf)
    zeta = 0.4;
    dampingConstant = zeta*2*sqrt(buildingStiffness*massOfBuilding);
   
    % ode45
    startTime = 0;
    endTime = 86400/4; % 6 hours
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
   
   % Display which zeta value is being used
   text(Times(18),Displacement(18),['\zeta = ' num2str(zeta) '']);
    
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
         currentAcceleration = currentForce/massOfBuilding; % PROBABLY NEED TO CHANGE MASS TO ADD IN PENDULUM MASS
         
         % Return the results, keep in mind ode45 will intergrate
         res = [currentV; currentAcceleration];
    end 
end