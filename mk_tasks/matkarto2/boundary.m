function[XB,YB] = boundary(R, uk, vk, s0, proj, ub, vb)
%Draw boundary lines (cutting edges)

%Transform to oblique aspect
[sb, db] = uv_sd(ub, vb, uk, vk);

%Threshold
s_min = 45 * pi/180;

%Project points
[XB, YB] = gnom(R, sb, db, s0);