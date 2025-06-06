clc
clear
hold on
axis equal

%Pole
uk = 1.134530475934230
vk = 0.389681826301047
s0 = 1.341268746211110
rho0 = 0.233521014593290
R = 1;

%Load points: Poland
N = load ("poland_txt.txt");
u = N(:,1) * pi/180;
v = N(:,2) * pi/180;

%Convert to oblique aspect
[s, d] = uv_sd(u, v, uk, vk);

%Project country
[xn, yn] = lambert(R, s, d, s0, rho0);
plot(-xn, yn, 'b', "LineWidth", 1.5);

%Compute graticule
umin = 48.5*pi/180;
umax = 55.5*pi/180;
vmin = 13*pi/180;
vmax = 25*pi/180;
Du = 1*pi/180;
Dv = 1*pi/180;
du = 0.1*pi/180;
dv = 0.1*pi/180;

proj = @lambert


[XM, YM, XP, YP] = graticule_lamb(umin, umax, vmin, vmax, Du, Dv, du, dv, R, uk, vk, s0, proj);
plot(-XM', YM', 'k');    
plot(-XP', YP', 'k');

%Mesh grid
[ug, vg] = meshgrid(umin:Du:umax, vmin:Dv:vmax)

%Convert to oblique aspect
[sg, dg] = uv_sd(ug, vg, uk, vk);

%Project meshgrid
[xg, yg] = lambert(R, sg, dg, s0, rho0)
%plot(xg, yg, 'o');

%Local linear scale
c = sin(s0);
% Calculate rho
rho = rho0 * (((tan(s0/2 + pi/4)) ./ (tan(sg/2 + pi/4))).^c);

% Local linear scale
m = c .* rho ./ (R*cos(sg));

%Distortion
mju = m-1;

%Distortions per km
mju_km = mju*1000;


%Contour lines
dz = 0.2;
[C, h] = contour(-xg, yg, mju_km,[-0.4:dz:20], 'LineColor', 'r');
clabel(C, h,'Color', 'red');
axis off

f = gcf;
set(gcf, 'Units', 'inches', 'Position', [1 1 12 12]);
exportgraphics(f, 'poland_lamb.png', 'Resolution', 600);