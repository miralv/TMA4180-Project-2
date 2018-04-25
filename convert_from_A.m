function x = convert_from_A(A,vec)
% construct x given symmetric nxn matrix A and a nx1 vector
n = size(A,1);
nvar = n*(n+1)/2 + n;
x = zeros(nvar,1);

%fill x(1:nvar-n) with the diagonals of A
start_index_i = 1;
for i =1:n
    %get the diagonal i- 1 elements from the main diagonal
    length_i = n-i+1;
    x(start_index_i:start_index_i + length_i-1)=diag(A,i-1);
    start_index_i = start_index_i + length_i;
end
% fill the last n elements of x with the elements of the vector
x(start_index_i:end)= vec;
end