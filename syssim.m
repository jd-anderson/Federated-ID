function [X_i,Z_i,W_i] = syssim(A,B,T,N,i,sigu,sigw,sigx)

n = size(A{i},1);
p = size(B{i},2);

x=zeros(n,T);
u = zeros(p,T);
w = zeros(n,T);
z=zeros(n+p,T);
X_i=zeros(n,T*N);
Z_i=zeros(n+p,T*N);
W_i=zeros(n,T*N);

for j=1:N
    x(:,1)=normrnd(0,sigx,[n,1]);
    for k=1:T
        u(:,k) = normrnd(0,sigu,[p,1]);
        w(:,k)=normrnd(0,sigw,[n,1]);
        z(:,k)=[x(:,k);u(:,k)];
        x(:,k+1)=A{i}*x(:,k) + B{i}*u(:,k) + w(:,k);
    end
    x=x(:,2:end);
    x=fliplr(x);
    z=fliplr(z);
    w=fliplr(w);
    X_i(:,1+(j-1)*T:j*T)=x;
    Z_i(:,1+(j-1)*T:j*T)=z;
    W_i(:,1+(j-1)*T:j*T)=w;
end
end