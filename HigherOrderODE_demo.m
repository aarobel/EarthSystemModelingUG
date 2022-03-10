%% Demo of predictor corrector method for 
%  calculating trajectory of volcanic bombs

H = 2000;                           %volcano height
g=9.81;                             %gravitational acceleration
v0 = 150;                           %initial velocity
theta0 = (30/360)*2*pi;             %initial angle

D = 1e-4;                           %air resistance

tf = 30;                            %final time
ti = 0;                             %initial time
n = 1000;                           %number of time steps

deltat = (tf-ti)/n;                 %length of time step

x = nan.*ones(n+1,1);               %initial conditions
z = nan.*ones(n+1,1);
vx = nan.*ones(n+1,1);
vz = nan.*ones(n+1,1);
x(1) = 0;
z(1) = H;
vx(1) = v0*cos(theta0);
vz(1) = v0*sin(theta0);

for i = 1:n                         %iterate for loop over time steps
    f_x = vx(i);                    %calculate FE approximations for RHS
    f_z = vz(i);
    f_vx = -D*(vx(i)^2);
    f_vz = -g-D*(vz(i)^2) * sign(vz(i));
    
    f2_x = vx(i)+f_vx*deltat;       %calculate predictor-corrector approx
    f2_z = vz(i)+f_vz*deltat;
    f2_vx = -D*(vx(i)+(f_vx*deltat))^2;
    f2_vz = -g-D*(vz(i)+(f_vz*deltat))^2 * sign(vz(i));
    
    x(i+1) = x(i) + (deltat/2)*(f_x + f2_x);    %update variables using P-C marching equation
    z(i+1) = z(i) + (deltat/2)*(f_z + f2_z);
    vx(i+1) = vx(i) + (deltat/2)*(f_vx + f2_vx);
    vz(i+1) = vz(i) + (deltat/2)*(f_vz + f2_vz);
   
end

figure;plot(x,z,'k','linewidth',3)  %plot trajectory
xlabel('x (m)','fontsize',26)
ylabel('z (m)','fontsize',26)
set(gca,'fontsize',26)
