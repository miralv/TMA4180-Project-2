function plot_ellipsoid(z,w,x)
modelnumber = 2;
    [A,vec]= build_A_vec(x,2);


    %plot in 2 dimensions
    n_gridpoints = 100;
    xmin = -2;
    xmax = 2;
    ymin = -2;
    ymax = 2;

    x = linspace(xmin,xmax,n_gridpoints);
    y = linspace(ymin,ymax,n_gridpoints);
    [X,Y]=meshgrid(x,y); 
    %need to reshape to find Z
    x_vec = reshape(X,1,n_gridpoints*n_gridpoints);
    y_vec = reshape(Y,1,n_gridpoints*n_gridpoints);
    z_vec = h([x_vec;y_vec],A,vec,modelnumber);
    Z = reshape(z_vec,n_gridpoints,n_gridpoints);

    %contour level
    v = [0;0]; 
    contour(X,Y,Z,v,'b');
    pause

 
end % visualization

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
