function [A,B] = sysgen(A_0,B_0,V,U,M,delta)

A={};
B={};
for i=1:M(end)
    A{i}=A_0 + delta*rand(1)*V;
    B{i}=B_0 + delta*rand(1)*U;
end 
end