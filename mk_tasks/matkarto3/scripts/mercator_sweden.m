clc
clear
hold on
axis equal

%Pole
uk = 0.155875902717580
vk = -1.621880273691130
s0 = 0.017426738799965
R = 6380;

%Load points: Poland
N = load ("sweden_txt.txt");
u = N(:,1) * pi/180;
v = N(:,2) * pi/180;

%Convert to oblique aspect
[s, d] = uv_sd(u, v, uk, vk);

%Project country
[xn, yn] = mercator(R, s, d, s0)
plot(-xn, yn, 'b', "LineWidth", 1.5);

%Compute graticule
umin = 55*pi/180;
umax = 70*pi/180;
vmin = 10*pi/180;
vmax = 25*pi/180;
Du = 1*pi/180;
Dv = 1*pi/180;
du = 0.1*pi/180;
dv = 0.1*pi/180;

proj = @mercator


[XM, YM, XP, YP] = graticule(umin, umax, vmin, vmax, Du, Dv, du, dv, R, uk, vk, s0, proj);
plot(-XM', YM', 'k');    
plot(-XP', YP', 'k');

%Mesh grid
[ug, vg] = meshgrid(umin:Du:umax, vmin:Dv:vmax)

%Convert to oblique aspect
[sg, dg] = uv_sd(ug, vg, uk, vk);

%Project meshgrid
[xg, yg] = mercator(R, sg, dg, s0)
%plot(xg, yg, 'o');

%Local linear scale
psig = pi/2 - sg;
psi0 = pi/2 - s0;
m = cos(s0) ./ cos(sg);

%Distortion
mju = m-1;

%Distortions per km
mju_km = mju*1000;

%Contour lines
dz = 0.25;
[C, h] = contour(-xg, yg, mju_km,[-20:dz:100], 'LineColor', 'r');
clabel(C, h,'Color', 'red');
axis off

f = gcf;
set(gcf, 'Units', 'inches', 'Position', [1 1 12 12]);
exportgraphics(f, 'sweden_mer.png', 'Resolution', 600);