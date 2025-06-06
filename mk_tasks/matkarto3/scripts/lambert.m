function [x, y] = lambert(R, s, d, s0, rho0)
    % Constant of projection
    c = sin(s0);
    
    % Projection equations, polar
    rho = rho0 .* (((tan(s0./2 + pi/4)) ./ (tan(s./2 + pi/4))).^c);
    eps = (c .* d);
    
    % Projection equation, cartesian
    x = rho .* sin(eps);
    y = -rho .* cos(eps);
end