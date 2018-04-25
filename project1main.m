function [] = main()
    rng(62); % set seed random number generator
    error = 0; % 0 or 1 
    epsilon = 1e-4;
    dim = 2; % matrix dimension
    m = 1000; % no. of z in test problem
    modelnumber = 2;
    method = 2;
  
    % Making testproblems
    [z,w,A_true,vec_true] = testproblems(m,dim,error,modelnumber);
    A_init = eye(dim);
    c_init = ones(dim,1);
    
    % Converting to single x
    x = convert_from_A(A_init,c_init);
    
    % Solve optimization problem
    switch method
        case 1
            x = BFGS(x,epsilon,z,w,dim);
        otherwise
            x = fletcher_reeves(x,epsilon,z,w,dim);
    end % switch
    
    % Reconstruct A and b/c 
    [A,vec] = build_A_vec(x,dim);
 
    % Plot and display error
    visualization(z,w,A,vec,A_true,vec_true, modelnumber);
    
end
