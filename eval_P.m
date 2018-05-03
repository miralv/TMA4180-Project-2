function [f] = eval_P(x,Z,w,mu,lambda_minbound,lambda_maxbound)
% Function evaluation of the objective function P
dim =2;
[A,b] = build_A_vec(x,dim);
m = length(w);
f = 0; 

for i = 1:m
    f = f + max((Z(:,i)'*A*Z(:,i) + b'*Z(:,i) - 1)*w(i),0)^2;
end
% Add the logarithmic terms
c = c_vec(x,lambda_minbound,lambda_maxbound);
for i = 1:length(c)
    if c(i)>0
        f = f - mu*log(c(i));
    else
        f = inf;
        return
    end
end


end