function [A,b] = initialGuess(lambda_minbound,lambda_maxbound)
% Construct a feasible initial guess
    A = eye(2);
    b = zeros(2,1);
    
    A(1,1) = (lambda_maxbound-lambda_minbound)*rand() + lambda_minbound;
    A(2,2) = (lambda_maxbound-lambda_minbound)*rand() + lambda_minbound;
    
    b(1) = (lambda_maxbound-lambda_minbound)*rand() + lambda_minbound;
    b(2) = (lambda_maxbound-lambda_minbound)*rand() + lambda_minbound;
    
    A(1,2) = (lambda_maxbound-lambda_minbound)*rand()+ lambda_minbound; 
    A(2,1) = A(1,2);
    while det(A) < lambda_minbound^2
       A(1,2) = (lambda_maxbound-lambda_minbound)*rand();
       A(2,1) = A(1,2);
    end
end

