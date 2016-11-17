% Return the force applied by the pendulum at a given angle
function res = pendulumForceOnBuilding(angle)
    % Set constants
    massPendulum = 100; % kg
    length = 4;         % m
    g = 9.8;            % m/s^2

    % Get angular acceleration (from equation found online)
    angularAcceleration = (-g/length * sin(angle));

    % Get translational acceleration (translationAcceleration =
    % radiusOfCurvature * angularAceleration)
    translationalAcceleration = angularAcceleration * length;

    % Force = mass * translationalAcceleration
    pendulumForce = massPendulum * translationalAcceleration;

    % Return the force applied by the pendulum at the given angle
    res = pendulumForce * sin(angle);
end