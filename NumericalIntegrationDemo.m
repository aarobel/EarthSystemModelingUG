%% Bounds
b = 6;
a = 1.2;

%% Numerical parameters
n = 1e7;
dx = (b-a)/n;

%% Function definition
fcn = @(x) x.^2;

%% Loop Integration
I = 0;

tic
for i = 0:n-1
    x = a + ((2*i+1)/2)*dx;
    I = I + (fcn(x) * dx);
end
toc

I

%% Vectorized Integration

ii = 0:n-1;
x = a + ((2*ii+1)/2)*dx;
y = fcn(x);
I = sum(y*dx);

%% Check error
ns = round(logspace(1,6,1e3));
error = nan.*ones(size(ns));
I_exact = (1/3)*(b^3-a^3);

for q = 1:length(ns)
    n = ns(q);
    dx = (b-a)/n;
    
    ii = 0:n-1;
    x = a + ((2*ii+1)/2)*dx;
    y = fcn(x);
    I = sum(y*dx);
    
    error(q) = abs(I-I_exact);
end

figure;
loglog(ns,error,'k.','markersize',25)

