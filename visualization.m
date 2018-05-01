function visualization(z,w,A,vec,A_true,vec_true)
    
    m=length(z);
    % Classify z based on A & b:
    classification = zeros(m,1);

    b = vec;
    for i=1:m
        if ((z(:,i)'*A*(z(:,i))) + b'*z(:,i)) <= 1
            classification(i)=1;
        else
            classification(i)=-1;
        end %if
    end %for

    
    
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
    xmin = -2;%1.35;
    xmax = 2;%1.35;
    ymin = -2;%1.35;
    ymax = 2;%1.35;

    n_gridpoints = 100;
    x = linspace(xmin,xmax,n_gridpoints);
    y = linspace(ymin,ymax,n_gridpoints);
    [X,Y]=meshgrid(x,y); 
    %need to reshape to find Z
    x_vec = reshape(X,1,n_gridpoints*n_gridpoints);
    y_vec = reshape(Y,1,n_gridpoints*n_gridpoints);
    z_vec = h([x_vec;y_vec],A,vec);
    Z = reshape(z_vec,n_gridpoints,n_gridpoints);
    z_vec_true = h([x_vec;y_vec],A_true,vec_true);
    Z_true = reshape(z_vec_true,n_gridpoints,n_gridpoints);

    %contour level
    v = [0;0]; 
    figure(2)
    [z1_pos,z1_neg,z2_pos,z2_neg]=find_points(z,w);
    plot(z1_pos,z2_pos,'r+');
    axis([xmin xmax ymin ymax])
    hold on
    plot(z1_neg,z2_neg,'go');
    contour(X,Y,Z,v,'b');
    contour(X,Y,Z_true,v,'k');
    xlabel('z_1')
    ylabel('z_2')


    title("Model 2")
    legend("w_i > 0","w_i \leq 0","S_{A,b}","True S_{A,b}");

    %print('mod2-met2-error','-depsc')


 
end % visualization

function res = h(Z,A,vector)
% Z nxm matrix of datapoints
% vector = c if model 1, b if model 2
m = size(Z,2);
res = zeros(1,m);

    for i = 1:m
        res(i) = Z(:,i)'*A*Z(:,i) + vector'*Z(:,i) - 1;
    end
    

end


