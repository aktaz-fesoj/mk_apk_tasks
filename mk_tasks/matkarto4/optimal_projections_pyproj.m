clc
clear
hold on
axis equal
format long

%Set Python interpreter
pyenv(Version="D:\v6\python\python.exe");

% Přidat cestu k mk.py
if count(py.sys.path, 'D:\MGR\2_semestr\matkarto\ukol4') == 0
    insert(py.sys.path, int32(0), 'D:\MGR\2_semestr\matkarto\ukol4');
end

py.importlib.import_module('mk')

%Projection properties
%proj_name = 'bonne';
%proj_name = 'sinu';
%proj_name = 'eck5';
%proj_name = 'wintri';
proj_name = 'hammer';
R = 1;

%Analyzed territory
umin = -60*pi/180;
umax = 20*pi/180;
vmin = -90*pi/180;
vmax = -30*pi/180;
Du = 5*pi/180;
Dv = 5*pi/180;
du = 0.1 * Du;
dv = 0.1 * Dv;
uk = 90*pi/180;
vk = -60*pi/180;
[u0, v0] = uv_sd(-20*pi/180, -60*pi/180, uk, vk);


%Mesh grid
[ug, vg] = meshgrid(umin:du:umax, vmin:dv:vmax);
[uu, vv] = uv_sd(ug, vg, uk, vk);
%Test: project + extract arrays from tuple and convert to matrix
vals = py.mk.project(proj_name, R, py.numpy.array(uu  * 180/pi), py.numpy.array(vv*180/pi), u0*180/pi, v0*180/pi);
XG = double(vals{1});
YG = double(vals{2});
a = double(vals{3});
b = double(vals{4});

%Airy Criterium (local)
h2a = ((a - 1).^2 + (b-1).^2)/2;

%Complex criterium (local)
h2c = (abs(a-1)+abs(b-1))/2 + a./b-1;

%Airy criterion (global)
H2a = mean(h2a(:))

%Complex criterion(global)
H2c = mean(h2c(:))

%Airy criterion(global, weighted)
w = cos(ug);
num = sum(w.*h2a);
den = sum(w);
H2aw = num/den

%Complex criterion (global, weighted)
w = cos(ug);
num = sum(w.*h2c);
den = sum(w);
H2cw = num/den

%Graticule
[XM, YM, XP, YP] = graticule_proj(umin, umax, vmin, vmax, Du, Dv, du, dv, R, uk, vk, u0, v0, proj_name);
plot(-XM', YM', 'k');    
plot(-XP', YP', 'k');

%Load continents
A = load("final_ja.txt");
[Au, Av] = uv_sd(A(:,1)*pi/180, A(:,2)*pi/180, uk, vk);
vals = py.mk.project(proj_name, R, Au*180/pi, Av*180/pi, u0*180/pi, v0*180/pi);
XA = double(vals{1});
YA = double(vals{2});

plot(-XA, YA, 'b', 'LineWidth', 1.5);

%Compute variable map scale
M = 30000000;
Muv = M./a;

%Draw contour line
Mmin = 10000000;
Mmax = 100000000;
dM = 1000000;
[C, h] = contour(-XG, YG, Muv, [Mmin:dM:Mmax], 'LineColor', 'r');
clabel(C, h,'Color', 'red');
axis off;