function [A,b] = build_A_vec(x,n)
% Build A, nxn and vector b nx1 
A(1,1)=x(1);
A(2,2)=x(2);
A(2,1)=x(3);
A(1,2)=x(3);
b = x(4:5); 
end