function [P_grad] = eval_Pgrad(mu,x,z,w,n)

[~,grad_f] = model_2eval(x,z,w,n);
