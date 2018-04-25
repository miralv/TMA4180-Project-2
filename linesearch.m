function [alpha] = linesearch(x,p,z,w,dim,c2)
   
    alpha = 1; % initial steplength
    c1 = 1e-4; 
    amin = 0;
    amax = +inf;
    [f,grad] = model_1eval(x,z,w,dim);
    [f_new,grad_new] = model_1eval(x+alpha*p,z,w,dim);

    % Get sufficient decrease
    while (f_new > f + c1*alpha*grad.'*p)
        amax = alpha;
        alpha = (amin + amax)/2;
        [f_new,grad_new] = model_1eval(x+alpha*p,z,w,dim);
    end % while

    % Curvature condition
    while (grad_new.'*p< c2*grad.'*p)
        amin = alpha;
        if (amax ==inf)
            alpha = 2*alpha;
        else
            alpha = (amin + amax)/2;
        end % if
        
        [~,grad_new] = model_1eval(x+alpha*p,z,w,dim);
    end % while
end % function