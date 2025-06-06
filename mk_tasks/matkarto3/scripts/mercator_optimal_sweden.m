clc
clear

format long g

%Input points, Equator
u1 = 55.589741 * pi / 180;
v1 = 10.336312 * pi / 180;

u2 = 70.314434 * pi / 180;
v2 = 23.129377 * pi / 180;

%Northern-most point
u3 = 63.598135 * pi / 180;
v3 = 12.170295 * pi / 180;


%Pole
vk = atan2(tan(u1)*cos(v2)-tan(u2)*cos(v1), tan(u2)*sin(v1)-tan(u1)*sin(v2));
uk = atan2(-cos(v2-vk),tan(u2));

%Transform to oblique aspect
[s1, d1] = uv_sd(u1, v1, uk, vk);
[s2, d2] = uv_sd(u2, v2, uk, vk);
[s3, d3] = uv_sd(u3, v3, uk, vk);


%True parallel
s0 = acos(2*cos(s3)/(1+cos(s3)));

%Local linear scales
m1 = cos(s0)/cos(s1)
m2 = cos(s0)/cos(s2)
m3 = cos(s0)/cos(s3)


%Distortions
mju1 = m1-1
mju2 = m2-1
mju3 = m3-1


%Distortions per km
mju1_km = mju1*1000
mju2_km = mju2*1000
mju3_km = mju3*1000


