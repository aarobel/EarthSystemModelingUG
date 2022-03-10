%% Parameters
W = 0.1;
p = 2e-4;
d = 2e-6;
b = 2e-6;

%% Time steps
dt = 1000;
n  = 1e6;

%% Pre-allocate solution vectors
M1 = nan.*ones(n,1);
M2 = nan.*ones(n,1);
t = nan.*ones(n,1);

%% Set initial conditions
M1(1) = W/b;
M2(1) = p*W/(d*b);
t(1) = 0;

%% Run the model (FE) - with increased W
W = 0.2;
p = 4e-4;
for i = 1:n-1
    
    M1(i+1) = M1(i) + (W + d*M2(i) - (p+b)*M1(i))*dt;
    M2(i+1) = M2(i) + (p*M1(i) - d*M2(i))*dt;
    t(i+1) = t(i) + dt;
end

%% Plot
figure;semilogy(t,M1,'b','linewidth',4);hold on
semilogy(t,M2,'r','linewidth',4);
xlabel('t (yr)','fontsize',24)
ylabel('M1/M2 (Gt)','fontsize',24)
set(gca,'fontsize',24)
legend('M1','M2')


