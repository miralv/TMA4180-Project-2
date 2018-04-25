function [A,vec] = build_A_vec(x,n)
% build A, nxn and vector b or c nx1 given the vector x and the dimension n
counter = 1;
A = diag(x(counter:n));
counter = n+1;
for i = 2:n
    number = n-i;
    A = A + diag(x(counter:counter+number),i-1) + diag(x(counter:counter+number),-i+1);
    counter = counter + number+1;
end
% build c/b := vec
nvar = n*(n+1)/2 + n;
% when calling the function, we know if we want c or b
vec = x(nvar-n+1:end);

end