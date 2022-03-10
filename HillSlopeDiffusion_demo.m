%% Parameters
D = 0.1;
L = 10;
H_max_init = 20;

dx = 2*L/201;
C_D = 0.5;
dt = (dx^2)*C_D/D;

tf = 100;

%x1 = 0:dx:2*L;
x = linspace(0,2*L,202);
%t1 = 0:dt:tf;
t = linspace(0,tf,tf/dt + 1);

%% Pre-allocate solution
h = zeros(length(x),1);
h(x<L) = H_max_init*x(x<L)/L;
h(x>L) = H_max_init*(1-(x(x>L)-L)/L);

h_all = zeros(length(x),length(t));
h_all(:,1) = h;
%% Matrix
M = sparse(length(x),length(x));

for i = 1:length(x)
    for j = 1:length(x)
        if i==j
            M(i,j) = 1-2*C_D;
        else if i-1==j
            M(i,j) = C_D;
        else if i+1==j
            M(i,j) = C_D;
        end;end;end
    end
end

%spdiags is another way to do this without for loops

%% Run model!
for k = 1:length(t)-1
    hnew = M*h;
    
    h_all(:,k+1) = hnew;
    h = hnew;
end
%% Plot stuff
figure;plot(x,h_all(:,1:100:end))