%Forward Euler Demo - Nuclear Decay

%% Do everything in a loop - using forward Euler
clear

% Problem solving: dN/dt = -lambda * N

n = 1000;             %number of time steps
N_0 = 100;           %initial condition
t_i = 0;                 %initial time
t_f = 10;               %final time
lambda = 1;          %set decay constant

N = zeros(n+1,1);    %pre-allocate space for N
N(1) = N_0;             %set initial condition
t = zeros(n+1,1);     %pre-allocate space for t
deltat = (t_f-t_i)/n;  %calculate time step length

for i = 1:n
    t(i+1) = t(i) + deltat; %calculate current time
    N(i+1) = N(i) + (-lambda*N(i))*deltat;  %calculate N at new time using FE marching equation
end

plot(t,N,'k-','linewidth',3)
xlabel('time (t)','fontsize',30)
ylabel('N(t)','fontsize',30)
set(gca,'fontsize',30)

N_exact = N_0*exp(-lambda*t);

hold on
plot(t,N_exact,'r--','linewidth',2)
legend('Numerical Solution','Exact Solution')

%% Code a general solution for any function
clear

n = 1000;             %number of time steps
N_0 = 100;           %initial condition
t_i = 0;                 %initial time
t_f = 10;               %final time
lambda = 1;         

N = zeros(n+1,1);    %pre-allocate space for N
N(1) = N_0;             %set initial condition
t = zeros(n+1,1);     %pre-allocate space for t
deltat = (t_f-t_i)/n;  %calculate time step length

myfun = @(N) -lambda*N^0.5 + 5*sin(N);      %define RHS function from ODE

for i = 1:n
    t(i+1) = t(i) + deltat; %calculate current time
    N(i+1) = N(i) + myfun(N(i))*deltat;  %calculate N at new time using FE marching equation
end

plot(t,N,'k-','linewidth',3)
xlabel('time (t)','fontsize',30)
ylabel('N(t)','fontsize',30)
set(gca,'fontsize',30)


%% Compare against an analytical solution at t = 10
clear

j = 0;
for n = 10:10:1000             %number of time steps
    j = j+1;
    N_0 = 100;           %initial condition
    t_i = 0;                 %initial time
    t_f = 10;               %final time
    lambda = 1;         

    N = zeros(n+1,1);    %pre-allocate space for N
    N(1) = N_0;             %set initial condition
    t = zeros(n+1,1);     %pre-allocate space for t
    deltat = (t_f-t_i)/n;  %calculate time step length

    myfun = @(N) -lambda*N;      %define RHS function from ODE

    for i = 1:n
        t(i+1) = t(i) + deltat; %calculate current time
        N(i+1) = N(i) + myfun(N(i))*deltat;  %calculate N at new time using FE marching equation
    end

    N_exact = N_0*exp(-lambda*t);          %calculate exact solution

    dts(j) = deltat;                                    %save time step length
    error(j) = abs(N_exact(end) - N(end));  %save error calculated at t=10
end

loglog(dts,error,'k.','markersize',20)
xlabel('\Delta t','fontsize',30)
ylabel('Error','fontsize',30)
set(gca,'fontsize',30)

%% Compare against an analytical solution using L2 norm
clear

j = 0;
for n = 10:10:1000             %number of time steps
    j = j+1;
    N_0 = 100;           %initial condition
    t_i = 0;                 %initial time
    t_f = 10;               %final time
    lambda = 1;         

    N = zeros(n+1,1);    %pre-allocate space for N
    N(1) = N_0;             %set initial condition
    t = zeros(n+1,1);     %pre-allocate space for t
    deltat = (t_f-t_i)/n;  %calculate time step length

    myfun = @(N) -lambda*N;      %define RHS function from ODE

    for i = 1:n
        t(i+1) = t(i) + deltat; %calculate current time
        N(i+1) = N(i) + myfun(N(i))*deltat;  %calculate N at new time using FE marching equation
    end

    N_exact = N_0*exp(-lambda*t);          %calculate exact solution

    dts(j) = deltat;                                    %save time step length
    error(j) = vecnorm(N-N_exact);           %save L2 norm error
end

loglog(dts,error,'k.','markersize',20)
xlabel('\Delta t','fontsize',30)
ylabel('Error','fontsize',30)
set(gca,'fontsize',30)


