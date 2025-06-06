function [x, y] = mercator(R, s, d, s0)
    % Mercator projection
    x = R * d;
    y = R * log(tan(pi/4 + s/2));
end