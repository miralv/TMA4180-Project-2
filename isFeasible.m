function res = isFeasible(x,lambda_minbound,lambda_maxbound)
% return 1 if x is in the feasible region omega, 0 if not 
[A,~] = build_A_vec(x);
res = (A(1,1)-lambda_minbound>=0) && (-A(1,1)+ lambda_maxbound >=0) && (A(2,2)- lambda_minbound >=0) && (-A(2,2) + lambda_maxbound >=0) && (sqrt(A(1,1)*A(2,2) - sqrt(lambda_minbound^2 + A(1,2)^2))>= 0);
end