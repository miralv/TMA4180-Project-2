function[z1_pos,z1_neg,z2_pos,z2_neg] = find_points(Z,w)
% Z nxm matrix with m data points of dimension n
% w mx1 vector with corresponding weights
% dimension = 2 or 3

filter = w>0;
%find x and y coordinates of Z with positive weight  
z1_pos = Z(1,filter);
z2_pos = Z(2,filter);
%find x and y coordinates of Z with negative weight  
z1_neg = Z(1,~filter);
z2_neg = Z(2,~filter); 
end
