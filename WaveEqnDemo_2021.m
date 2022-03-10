%Demo of wave equation with change in wave speed
%Equation to solve: u_tt - alpha*u_xx = 0
%
%Boundary conditions:
%1. Mirror: u(x=0,L) = 0 -> no change in matrix
%2. Reflective u_x(x=0,L) = 0 -> 2-lambda^2 at boundary diags
%3. Periodic: u(x=0) = u(x=L)
%% Set parameters
alpha1 = 1;
alpha2 = 2;

tf = 100;
L = 30;
%% Initialize grids
dx = 0.1;
dt = 0.01;

x = 0:dx:L;
t = 0:dt:tf;

nx = length(x);
nt = length(t);

% lambda = (alpha1*dt/dx).*ones(nx,1);
lambda = [(alpha1*dt/dx).*ones((nx-1)/3,1);(alpha2*dt/dx).*ones((nx-1)/3+1,1);(alpha1*dt/dx).*ones((nx-1)/3,1)];

%% Set of finite difference propagator matrix
M = spdiags([lambda.^2 2*(1-lambda.^2) lambda.^2],-1:1,nx,nx);

%% Boundary conditions
%Reflective u_x(x=0,L) = 0 -> 2-lambda^2 at boundary diags
M(1,1) = 2-lambda(1)^2;
M(nx,nx) = 2-lambda(nx)^2;

%% Initial Conditions
u = zeros(nx,nt);
u(:,1) = exp(-(x-15).^2 ./ 2);
u(:,2) = exp(-(x-15).^2 ./ 2); %implies that u_t(t=0) = 0

%% Run Model
for k = 2:nt 
    u(:,k+1) = M*u(:,k) - u(:,k-1);
end

%% Plot
for k = 1:10:nt
    figure(1);
    plot(x,u(:,k),'k','linewidth',3);ylim([-1 1])
    xlabel('x','fontsize',20);
    ylabel('u','fontsize',20);
    set(gca,'fontsize',20)
%     pause(0.05)
end
    

