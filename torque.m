%Hello World

% Set varaibles
pendulumLength = 5; 
pendulumForce = 50; % Will need to call to equation to get actual pendulum force
buildingHeight = 200; 
buildingBase = 100;
buildingMass = 10000;
appliedForce = 100;

% Torque due applied force
torqueApplied = buildingHeight * appliedForce;

% Torque due to pendulum force 
torquePendulum = pendulumLength * pendulumForce; 

% Sum of torques
sumTorques = torquePendulum - torqueApplied;

% Translational acceleration
acceleration = 12*(sumTorques)/((buildingBase^2 + buildingBase^2) * buildingMass)