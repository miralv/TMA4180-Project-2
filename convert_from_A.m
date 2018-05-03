function x = convert_from_A(A,b)
% Construct x given symmetric nxn matrix A and a nx1 vector
x(1)=A(1,1);
x(2)=A(2,2);
x(3)=A(2,1);
x(4:5)=b;
x = x';

end