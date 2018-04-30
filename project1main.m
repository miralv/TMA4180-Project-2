
%rng(62); % set seed random number generator
error = 0; % 0 or 1 
epsilon = 1e-4;
dim = 2; % matrix dimension
m = 1000; % no. of z in test problem
modelnumber = 2;
lambda_minbound = 0.5;
lambda_maxbound = 10;
mu = 1;
%x0 = [1,1,0,0,0]';
% Making testproblems
[z,w,A_true,vec_true] = testproblems(m,dim,error,modelnumber);
A_init = eye(dim);
b_init = ones(dim,1);

% Converting to single x
x0 = convert_from_A(A_init,b_init);

% Solve optimization problem
%x = BFGS(mu,x,epsilon,z,w,lambda_minbound,lambda_maxbound);
x = unconstrained_primal_barrier(x0, z, w,lambda_minbound,lambda_maxbound);

% Reconstruct A and b/c 
[A,vec] = build_A_vec(x,dim);

% Plot and display error
visualization(z,w,A,vec,A_true,vec_true, modelnumber);


