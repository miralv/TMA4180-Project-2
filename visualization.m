function visualization(z,w,A,vec,A_true,vec_true, modelnumber)
    
    m=length(z);
    % Classify z based on A & c/b:
    classification = zeros(m,1);
    if (modelnumber == 1)
        c = vec;
        for i=1:m
            if ((z(:,i)-c).'*A*(z(:,i)-c)) <= 1
                classification(i)=1;
            else
                classification(i)=-1;
            end %if
        end %for
    else 
        b = vec;
        for i=1:m
            if ((z(:,i)'*A*(z(:,i))) + b'*z(:,i)) <= 1
                classification(i)=1;
            else
                classification(i)=-1;
            end %if
        end %for
    end %if
    
    
    total = sum(w==classification);
    m = length(w);
    true_pos_classified = sum(w==classification & w==1);
    true_pos_total = sum(w==1);
    true_neg_classified = sum(w==classification & w==-1);
    true_neg_total =sum(w==-1);
    sensitivity = true_pos_classified/true_pos_total;
    specificity = true_neg_classified/true_neg_total;
      
    fprintf('Sensitivity %.3f \n',sensitivity)
    fprintf('Specificity %.3f \n',specificity)
    fprintf('%i points out of %i correctly classified.\n',total,m)
    
    % Plot ellipses and data points
    switch modelnumber
        case 1
            xmin = -0.6;
            xmax = 2.6;
            ymin = -0.6;
            ymax = 2.6;
        case 2
            xmin = -3;%1.35;
            xmax = 3;%1.35;
            ymin = -3;%1.35;
            ymax = 3;%1.35;
    end

    %plot in 2 dimensions
    n_gridpoints = 100;
    x = linspace(xmin,xmax,n_gridpoints);
    y = linspace(ymin,ymax,n_gridpoints);
    [X,Y]=meshgrid(x,y); 
    %need to reshape to find Z
    x_vec = reshape(X,1,n_gridpoints*n_gridpoints);
    y_vec = reshape(Y,1,n_gridpoints*n_gridpoints);
    z_vec = h([x_vec;y_vec],A,vec,modelnumber);
    Z = reshape(z_vec,n_gridpoints,n_gridpoints);
    z_vec_true = h([x_vec;y_vec],A_true,vec_true,modelnumber);
    Z_true = reshape(z_vec_true,n_gridpoints,n_gridpoints);

    %contour level
    v = [0;0]; 
    figure(1)
    [z1_pos,z1_neg,z2_pos,z2_neg]=find_points(z,w,2);
    plot(z1_pos,z2_pos,'r+');
    axis([xmin xmax ymin ymax])
    hold on
    plot(z1_neg,z2_neg,'go');
    contour(X,Y,Z,v,'b');
    contour(X,Y,Z_true,v,'k');
    xlabel('z_1')
    ylabel('z_2')

    switch modelnumber
        case 1
            title("Model 1")
            legend("w_i > 0","w_i \leq 0","S_{A,c}","True S_{A,c}");
        case 2 
            title("Model 2")
            legend("w_i > 0","w_i \leq 0","S_{A,b}","True S_{A,b}");
    end
    print('mod2-met2','-depsc')
    

    %plot in 2 dimensions
    n_gridpoints = 100;
    x = linspace(xmin,xmax,n_gridpoints);
    y = linspace(ymin,ymax,n_gridpoints);
    [X,Y]=meshgrid(x,y); 
    %need to reshape to find Z
    x_vec = reshape(X,1,n_gridpoints*n_gridpoints);
    y_vec = reshape(Y,1,n_gridpoints*n_gridpoints);
    z_vec = h([x_vec;y_vec],A,vec,modelnumber);
    Z = reshape(z_vec,n_gridpoints,n_gridpoints);
    z_vec_true = h([x_vec;y_vec],A_true,vec_true,modelnumber);
    Z_true = reshape(z_vec_true,n_gridpoints,n_gridpoints);

    %contour level
    v = [0;0]; 
    figure(1)
    [z1_pos,z1_neg,z2_pos,z2_neg]=find_points(z,w,2);
    plot(z1_pos,z2_pos,'r+');
    axis([xmin xmax ymin ymax])
    hold on
    plot(z1_neg,z2_neg,'go');
    contour(X,Y,Z,v,'b');
    contour(X,Y,Z_true,v,'k');
    xlabel('z_1')
    ylabel('z_2')

    switch modelnumber
        case 1
            title("Model 1")
            legend("w_i > 0","w_i \leq 0","S_{A,c}","True S_{A,c}");
        case 2 
            title("Model 2")
            legend("w_i > 0","w_i \leq 0","S_{A,b}","True S_{A,b}");
    end
    print('mod2-met2-error','-depsc')


 
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


function[z1_pos,z1_neg,z2_pos,z2_neg,z3_pos,z3_neg] = find_points(Z,w,dimension)
% Z nxm matrix with m data points of dimension n
% w mx1 vector with corresponding weights
% dimension = 2 or 3

filter = w>0;
%find x and y coordinates of Z with positive weight  
z1_pos = Z(1,filter);
z2_pos = Z(2,filter);
%find x and y coordinates of Z with negative weight  
z1_neg = Z(1,~filter);
z2_neg = Z(2,~filter); 
if dimension == 3
    z3_pos = Z(3,filter);
    z3_neg = Z(3,~filter); 
end
end



