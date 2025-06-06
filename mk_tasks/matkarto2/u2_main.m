clc
clear

%Common parameters
file = 'continents_points/eur.txt';
proj = @gnom;
s0 = 0; % Might not be needed
spac_u = deg_to_rad(10);
spac_v = spac_u ;
dens_u = deg_to_rad(1);
dens_v = dens_u;
%M = 100000000; % Needs adjustement
R = 6380*1000;
% Height of dodecahedron = 7.5 cm
Rt = 0.0375;
M = R/Rt; % Probably around 170000000
R = Rt;


% Boundaries points
run("define_boundary_points.m");

% Face 01 [A, B, C, D, E, A]
% Graticule params
umin = deg_to_rad(40); % South of the southernmost point
umax = deg_to_rad(90); % North of the northernmost point
vmin = - deg_to_rad(0); % West of the westernmost point
vmax = deg_to_rad(360); % East of the easternmost point

uk = deg_to_rad(90); % Lat of the cartographic pole
vk = deg_to_rad(0); % Long of the cartographic pole

ub = [Au, Bu, Cu, Du, Eu, Au];
vb = [Av, Bv, Cv, Dv, Ev, Av];

subplot(3, 4, 1);
globeFace(umin, umax, vmin, vmax, spac_u, spac_v, dens_u, dens_v, R, uk, vk, s0, proj, ub, vb);

% Face 02 [A, F, G, H, B, A]
% Graticule params
umin = deg_to_rad(-20); % South of the southernmost point
umax = deg_to_rad(60); % North of the northernmost point
vmin = deg_to_rad(-10); % West of the westernmost point
vmax = deg_to_rad(80); % East of the easternmost point

uk = u1_n; % Lat of the cartographic pole
vk = Gv; % Long of the cartographic pole

ub = [Au, Fu, Gu, Hu, Bu, Au];
vb = [Av, Fv, Gv, Hv, Bv, Av];

subplot(3, 4, 2);
globeFace(umin, umax, vmin, vmax, spac_u, spac_v, dens_u, dens_v, R, uk, vk, s0, proj, ub, vb);

% Face 03 [B, H, I, J, C, B]
% Graticule params
umin = deg_to_rad(-20); % South of the southernmost point
umax = deg_to_rad(60); % North of the northernmost point
vmin = deg_to_rad(60); % West of the westernmost point
vmax = deg_to_rad(150); % East of the easternmost point

uk = u1_n; % Lat of the cartographic pole
vk = Iv; % Long of the cartographic pole

ub = [Bu, Hu, Iu, Ju, Cu, Bu];
vb = [Bv, Hv, Iv, Jv, Cv, Bv];

subplot(3, 4, 3);
globeFace(umin, umax, vmin, vmax, spac_u, spac_v, dens_u, dens_v, R, uk, vk, s0, proj, ub, vb);

% Face 04 [C, J, K, L, D, C]
% Graticule params
umin = deg_to_rad(-20); % South of the southernmost point
umax = deg_to_rad(60); % North of the northernmost point
vmin = deg_to_rad(140); % West of the westernmost point
vmax = deg_to_rad(220); % East of the easternmost point

uk = u1_n; % Lat of the cartographic pole
vk = Kv; % Long of the cartographic pole

ub = [Cu, Ju, Ku, Lu, Du, Cu];
vb = [Cv, Jv, Kv, Lv, Dv, Cv];

subplot(3, 4, 4);
globeFace(umin, umax, vmin, vmax, spac_u, spac_v, dens_u, dens_v, R, uk, vk, s0, proj, ub, vb);

% Face 05 [D, L, M, N, E, D]
% Graticule params
umin = deg_to_rad(-20); % South of the southernmost point
umax = deg_to_rad(60); % North of the northernmost point
vmin = deg_to_rad(210); % West of the westernmost point
vmax = deg_to_rad(300); % East of the easternmost point

uk = u1_n; % Lat of the cartographic pole
vk = Mv; % Long of the cartographic pole

ub = [Du, Lu, Mu, Nu, Eu, Du];
vb = [Dv, Lv, Mv, Nv, Ev, Dv];

subplot(3, 4, 5);
globeFace(umin, umax, vmin, vmax, spac_u, spac_v, dens_u, dens_v, R, uk, vk, s0, proj, ub, vb);

% Face 06 [E, N, O, F, A, E]
% Graticule params
umin = deg_to_rad(-20); % South of the southernmost point
umax = deg_to_rad(60); % North of the northernmost point
vmin = deg_to_rad(280); % West of the westernmost point
vmax = deg_to_rad(370); % East of the easternmost point

uk = u1_n; % Lat of the cartographic pole
vk = Ov; % Long of the cartographic pole

ub = [Eu, Nu, Ou, Fu, Au, Eu];
vb = [Ev, Nv, Ov, Fv, Av, Ev];

subplot(3, 4, 6);
globeFace(umin, umax, vmin, vmax, spac_u, spac_v, dens_u, dens_v, R, uk, vk, s0, proj, ub, vb);

% Face 07 [H, G, P, Q, I, H]
% Graticule params
umin = - deg_to_rad(60); % South of the southernmost point
umax = deg_to_rad(20); % North of the northernmost point 
vmin = deg_to_rad(30); % West of the westernmost point
vmax = deg_to_rad(120); % East of the easternmost point

uk = u1_s; % Lat of the cartographic pole
vk = Hv; % Long of the cartographic pole

ub = [Hu, Gu, Pu, Qu, Iu, Hu];
vb = [Hv, Gv, Pv, Qv, Iv, Hv];

subplot(3, 4, 7);
globeFace(umin, umax, vmin, vmax, spac_u, spac_v, dens_u, dens_v, R, uk, vk, s0, proj, ub, vb);

% Face 08 [J, I, Q, R, K, J]
% Graticule params
umin = - deg_to_rad(60); % South of the southernmost point
umax = deg_to_rad(20); % North of the northernmost point 
vmin = deg_to_rad(100); % West of the westernmost point
vmax = deg_to_rad(190); % East of the easternmost point

uk = u1_s; % Lat of the cartographic pole
vk = Jv; % Long of the cartographic pole

ub = [Ju, Iu, Qu, Ru, Ku, Ju];
vb = [Jv, Iv, Qv, Rv, Kv, Jv];

subplot(3, 4, 8);
globeFace(umin, umax, vmin, vmax, spac_u, spac_v, dens_u, dens_v, R, uk, vk, s0, proj, ub, vb);

% Face 09 [L, K, R, S, M, L]
% Graticule params
umin = - deg_to_rad(60); % South of the southernmost point
umax = deg_to_rad(20); % North of the northernmost point 
vmin = deg_to_rad(170); % West of the westernmost point
vmax = deg_to_rad(260); % East of the easternmost point

uk = u1_s; % Lat of the cartographic pole
vk = Lv; % Long of the cartographic pole

ub = [Lu, Ku, Ru, Su, Mu, Lu];
vb = [Lv, Kv, Rv, Sv, Mv, Lv];

subplot(3, 4, 9);
globeFace(umin, umax, vmin, vmax, spac_u, spac_v, dens_u, dens_v, R, uk, vk, s0, proj, ub, vb);

% Face 10 [N, M, S, T, O, N]
% Graticule params
umin = - deg_to_rad(60); % South of the southernmost point
umax = deg_to_rad(20); % North of the northernmost point 
vmin = deg_to_rad(240); % West of the westernmost point
vmax = deg_to_rad(330); % East of the easternmost point

uk = u1_s; % Lat of the cartographic pole
vk = Nv; % Long of the cartographic pole

ub = [Nu, Mu, Su, Tu, Ou, Nu];
vb = [Nv, Mv, Sv, Tv, Ov, Nv];

subplot(3, 4, 10);
globeFace(umin, umax, vmin, vmax, spac_u, spac_v, dens_u, dens_v, R, uk, vk, s0, proj, ub, vb);

% Face 11 [F, O, T, P, G, F]
% Graticule params
umin = - deg_to_rad(60); % South of the southernmost point
umax = deg_to_rad(20); % North of the northernmost point 
vmin = deg_to_rad(320); % West of the westernmost point
vmax = deg_to_rad(400); % East of the easternmost point

uk = u1_s; % Lat of the cartographic pole
vk = Fv; % Long of the cartographic pole

ub = [Fu, Ou, Tu, Pu, Gu, Fu];
vb = [Fv, Ov, Tv, Pv, Gv, Fv];

subplot(3, 4, 11);
globeFace(umin, umax, vmin, vmax, spac_u, spac_v, dens_u, dens_v, R, uk, vk, s0, proj, ub, vb);

% Face 12 [T, S, R, Q, P, T]
% Graticule params
umin = - deg_to_rad(90); % South of the southernmost point
umax = deg_to_rad(-40); % North of the northernmost point
vmin = - deg_to_rad(0); % West of the westernmost point
vmax = deg_to_rad(360); % East of the easternmost point

uk = - deg_to_rad(90); % Lat of the cartographic pole
vk = deg_to_rad(0); % Long of the cartographic pole

ub = [Tu, Su, Ru, Qu, Pu, Tu];
vb = [Tv, Sv, Rv, Qv, Pv, Tv];

subplot(3, 4, 12);
globeFace(umin, umax, vmin, vmax, spac_u, spac_v, dens_u, dens_v, R, uk, vk, s0, proj, ub, vb);
set(gcf, 'Renderer', 'painters'); % Matlab defaults to pixels, force vector rendering here
print(gcf, 'faces_export.svg', '-dsvg'); % Export as svg file