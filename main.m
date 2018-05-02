close all
clear

%rng(19); % set seed random number generator
error = 0; % 0 or 1 
epsilon = 1e-2;
dim = 2; % matrix dimension
m = 30; % no. of z in test problem

% If modelnumber == 2, we make a non-elliptic test-problem. 
modelnumber = 2;
lambda_minbound = 0.1;
lambda_maxbound = 100;
mu = 1;
max_iter = 200;

% Making testproblems
[z,w,A_true,vec_true] = testproblems(m,dim,error,modelnumber);
[A_init, b_init] = initialGuess(lambda_minbound, lambda_maxbound);


% Plot points
%[z1_pos,z1_neg,z2_pos,z2_neg] = find_points(z,w);
%figure(1)
%plot(z1_pos,z2_pos,'r+');
%hold on
%plot(z1_neg,z2_neg,'go');
% Converting to single x
x0 = convert_from_A(A_init,b_init);

% Solve optimization problem
x = unconstrained_primal_barrier(x0, z, w,lambda_minbound,lambda_maxbound, epsilon,max_iter);

% Reconstruct A and b/c 
[A,vec] = build_A_vec(x,dim);
eig(A)
% Plot and display error
visualization(z,w,A,vec,A_true,vec_true);
