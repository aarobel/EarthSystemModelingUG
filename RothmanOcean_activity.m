%% Parameters
W = 0.1;

b = 2e-6;
d=2e-6;
p = 2e-4;

%% Time steps
deltat = 1e3;
n = 1e6;

%% Pre-allocate and set initial conditions
M1 = nan.*ones(n,1);
M2 = nan.*ones(n,1);
ts = nan.*ones(n,1);

M1(1) = 1e4;
M2(1) = 1e6;
ts(1) = 0;

%% Forward Euler for loop
for t = 1:n
    
    ts(t+1) = ts(t) + deltat;
    M1(t+1) = M1(t) + deltat*(W + d*M2(t) - (p+b)*M1(t));
    M2(t+1) = M2(t) + deltat*(p*M1(t) - d*M2(t));
    
end

%% Plot
figure;plot(ts,M1,'linewidth',4);hold on;plot(ts,M2,'linewidth',4)

%% Volcanic eruption
deltat = 1000;
n = 100000;

M1v = nan.*ones(n,1);
M2v = nan.*ones(n,1);
tsv = nan.*ones(n,1);

M1v(1) = M1(end);
M2v(1) = M2(end);
tsv(1) = 0;


for t = 1:n

    if(t==1)
        W=1;
    else
        W=0.1;
    end
    
    tsv(t+1) = tsv(t) + deltat;
    M1v(t+1) = M1v(t) + deltat*(W + d*M2v(t) - (p+b)*M1v(t));
    M2v(t+1) = M2v(t) + deltat*(p*M1v(t) - d*M2v(t));
    
end

%% Plot
figure;semilogy(tsv,M1v,'linewidth',4);hold on;semilogy(tsv,M2v,'linewidth',4)
