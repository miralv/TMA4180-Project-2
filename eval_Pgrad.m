function [P_grad] = eval_Pgrad(mu,x,z,w,lambda_minbound, lambda_maxbound)
n = 2;
[~,grad_f] = model_2eval(x,z,w,n);
grad_c = mu*c_grad(x, lambda_minbound, lambda_maxbound);
P_grad = grad_f + grad_c;
end
