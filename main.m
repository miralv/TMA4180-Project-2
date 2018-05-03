close all
clear
rng(19); % set seed random number generator
dim = 2; % matrix dimension
m = 100; % no. of z in test problem
lambda_minbound = 5;
lambda_maxbound = 10;
epsilon = 1e-2;
max_iter = 100;

% Choose modeltype
% If model number == 1, we make an elliptic test-problem
% If modelnumber == 2, we make a non-elliptic test-problem.
modelnumber = 1;



% Making testproblems
[z,w,A_true,vec_true] = testproblems(m,dim,modelnumber);
[A_init, b_init] = initialGuess(lambda_minbound, lambda_maxbound);

% Converting to single x
x0 = convert_from_A(A_init,b_init);

% Solve optimization problem
x = unconstrained_primal_barrier(x0, z, w,lambda_minbound,lambda_maxbound, epsilon,max_iter,modelnumber);

% Reconstruct A and b/c 
[A,vec] = build_A_vec(x,dim);

% Plot and display error
visualization(z,w,A,vec,A_true,vec_true);

