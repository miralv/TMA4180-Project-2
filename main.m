
%rng(19); % set seed random number generator
error = 0; % 0 or 1 
epsilon = 1e-4;
epsilon2 = 1e-6;
dim = 2; % matrix dimension
m = 30; % no. of z in test problem
modelnumber = 2;
lambda_minbound = 0.2;
lambda_maxbound = 100;
mu = 1;

% Making testproblems
[z,w,A_true,vec_true] = testproblems(m,dim,error,modelnumber);
A_init = eye(dim);
b_init = ones(dim,1);

% Converting to single x
x0 = convert_from_A(A_init,b_init);

% Solve optimization problem
x = unconstrained_primal_barrier(x0, z, w,lambda_minbound,lambda_maxbound, epsilon2);

% Reconstruct A and b/c 
[A,vec] = build_A_vec(x,dim);

% Plot and display error
visualization(z,w,A,vec,A_true,vec_true, modelnumber);
