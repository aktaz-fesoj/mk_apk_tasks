function [x, y] = stereo(R, s, d, s0)
    	%Stereographic projection in oblique aspect
	psi = pi/2 - s
	psi0 = pi/2 - s0 
	ro = 2*R*cos(psi0/2)^2 * tan(psi/2)
	eps = d
	x = ro .* sin(eps) 
	y = ro .* cos(eps)
end
