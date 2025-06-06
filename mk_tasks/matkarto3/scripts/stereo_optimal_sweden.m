clc
clear

format long g

R = 1;

%Pole
uk = 61.666491*pi/180; 
vk = 18.247463*pi/180;

%Southern-most point
u1 = 67.950427*pi/180;
v1 = 23.662152*pi/180;

% Convert to oblique aspect
[s1, d1] = uv_sd(u1, v1, uk, vk);

%Substitution
psi1 = pi/2 - s1;

%Compute mju
mju = (2*cos(psi1/2)^2)/(1+(cos(psi1/2)^2))

%Psi0
psi0 = 2*acos(sqrt(mju));
s0 = pi/2 - psi0;

%Local linear scales
m1=mju/(cos(psi1/2)^2);
m2=mju/(cos(0)^2);
m0=mju/(cos(psi0/2)^2);


%Distortions
mju1 = m1-1;
mju2 = m2-1;
mju0 = m0-1;

%Distortions per km
mju1_km = mju1*1000
mju2_km = mju2*1000
mju0_km = mju0*1000

