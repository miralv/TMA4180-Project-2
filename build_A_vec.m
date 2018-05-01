function [A,vec] = build_A_vec(x,n)
% Build A, nxn and vector b nx1 

counter = 1;
A = diag(x(counter:n));
counter = n+1;
for i = 2:n
    number = n-i;
    A = A + diag(x(counter:counter+number),i-1) + diag(x(counter:counter+number),-i+1);
    counter = counter + number+1;
end
% Build c/b := vec
nvar = n*(n+1)/2 + n;
% The last n elements of x is b
vec = x(nvar-n+1:end);
end