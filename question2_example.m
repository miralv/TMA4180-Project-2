%% Question 2
% for both problems present an instance where the globally optimal solution
% exist, but is not unique.
% model 1
% let n = 2
close all
clear 
model = 2;
rng(100)
switch model
    case 1
    n = 2;
    m = 12;
    A = [1,0;0,1];
    c1 = [-1,1]';
    c2 = [2,1]';
    %plot the two circles
    figure(1)
    r = 1;
    theta = [0:0.01:2*pi];
    plot(c1(1) + r*cos(theta),c1(2) + r*sin(theta),'k')
    hold on 
    plot(c2(1) + r*cos(theta),c2(2) +r*sin(theta),'k')
    axis equal
    axis([-2.5,3.5,-0.5,2.5 ])
    % generate 10 points inside both of the circles.
    % the points in A_2 are the reflection of the points in A_1 so that 
    % the distance from the points to the other circles is the same on both
    % sides
    n_inside = 100;
    theta = rand(n_inside,1)*2*pi;
    radius = r.*rand(n_inside,1);
    R = diag(radius);
    points = [cos(theta)';sin(theta)']*R;
    reflect = [-1,0;0,1];
    points_A1 = points + c1;
    points_A2 = reflect*points + c2;

    p_A1 = plot(points_A1(1,:),points_A1(2,:),'+')
    p_A2 = plot(points_A2(1,:),points_A2(2,:),'+')


    %define the points outside the circles
    n_outside = 1000;
    x_max = 3.5;
    x_min = -2.5;
    y_max = 2.5;
    y_min = -0.5;
    z_out = zeros(n,n_outside);
    number = 1;
    while number <= n_outside
        x = x_min + (x_max-x_min)*rand(1);
        y = y_min + (y_max-y_min)*rand(1);
        while inA(x,y,c1,r) || inA(x,y,c2,r)
            x = x_min + (x_max-x_min)*rand(1);
            y = y_min + (y_max-y_min)*rand(1);
        end
        z_out(:,number)= [x;y];
        number = number + 1; 
    end

    p_out = plot(z_out(1,:),z_out(2,:),'o')
    legend([p_A1,p_A2,p_out],"z_i \in S_{A,c_1}, w_i > 0","z_i \in S_{A,c_2}, w_i > 0","w_i \leq 0")
    xlabel("z_1")
    ylabel("z_2")
    title("Method 1: Two globally optimal solutions")




case 2
    % Method 2
    modelnumber = 2;
    n = 2;
    m = 1;
    z = zeros(n,m);
    w = ones(m,1);
    vec = zeros(2,1);%b
    A_1 = eye(1);
    %A_2 = eye(1)+ rand(2);
    A_2 = [1,-4;1,0];

    %want to plot more than one optimal solution to  this instance
    %plot in 2 dimensions
    n_gridpoints = 100;
    xmin = -1.7;
    ymin = -1.7;
    xmax = 1.7;
    ymax = 1.7;
    x = linspace(xmin,xmax,n_gridpoints);
    y = linspace(ymin,ymax,n_gridpoints);
    [X,Y]=meshgrid(x,y); 
    %need to reshape to find Z
    x_vec = reshape(X,1,n_gridpoints*n_gridpoints);
    y_vec = reshape(Y,1,n_gridpoints*n_gridpoints);
    z_vec_1 = h([x_vec;y_vec],A_1,vec,modelnumber);
    Z_1 = reshape(z_vec_1,n_gridpoints,n_gridpoints);
    z_vec_2 = h([x_vec;y_vec],A_2,vec,modelnumber);
    Z_2 = reshape(z_vec_2,n_gridpoints,n_gridpoints);

    %contour level
    v = [0;0]; 
    plot(z(1),z(2),'r+');
    axis([xmin xmax ymin ymax]);
    hold on
    contour(X,Y,Z_1,v,'b');
    contour(X,Y,Z_2,v);
    legend("w_i > 0","S_{A_1,b}","S_{A_2,b}");
    xlab = xlabel('z_1');
    xlab = ylabel('z_2');
    title("Method 2");
        
        

end        
function res = inA(x,y,c,r)
res = 0;
if (x-c(1))^2 + (y - c(2))^2 <= r^2
    res = 1;
end
end

function res = h(Z,A,vector,model)
% Z nxm matrix of datapoints
% vector = c if model 1, b if model 2
m = size(Z,2);
res = zeros(1,m);
if model ==1
    for i = 1:m
        res(i) = (Z(:,i) - vector)'*A*(Z(:,i) - vector) - 1;
    end
else
    for i = 1:m
        res(i) = Z(:,i)'*A*Z(:,i) + vector'*Z(:,i) - 1;
    end
    
end
end