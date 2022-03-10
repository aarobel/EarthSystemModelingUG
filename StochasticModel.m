u = @(x,y) sin(pi*x).*cos(pi*y);
v = @(x,y) cos(pi*x).*sin(pi*y);
dt=0.1;
noise=1e-1;

for iter = 1
    x = zeros(1001,1);
    y = zeros(1001,1);
    x(1) = 2;
    y(1) = 0.5;
    
    for t = 1:1000
        x(t+1) = x(t) + u(x(t),y(t))*dt + noise.*sqrt(dt)*randn(1);
        y(t+1) = y(t) + v(x(t),y(t))*dt + noise.*sqrt(dt)*randn(1);
    end
%     hold on;plot(x,y);drawnow
end