function res = model_2(A,b,Z,w)
% Function evaluation of f

m = length(b);
res = 0;
for i = 1:m
    if w(i)>0
        res = res + (max(Z(:,i)'*A*Z(:,i) + b'*Z(:,i) - 1,0))^2;
    else
        res = res + (max(1 - Z(:,i)'*A*Z(:,i) - b'*Z(:,i),0))^2;
    end
end     
end