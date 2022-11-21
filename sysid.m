function [Error] = sysid(A,B,T,N,M,R,sigu,sigx,sigw,FL_solver,s)

n = size(A{1},1);
p = size(B{1},2);

% Generating the system trajectories:

% Simulate the dynamical system 
% x_{t+1} = Ax_t + Bu_t + w_t

X={};
Z={};
W={};
for i=1:M
    [X{i},Z{i},W{i}] = syssim(A,B,T,N,i,sigu,sigw,sigx);
end


% FedSysID

%Initialize the server with \bar{\Theta}_0 and \alpha


Theta_0=[(1/2)*A{s} (1/2)*B{s}];
alpha=1e-4; %step size
K=10; %number of local iterations

Theta_s=Theta_0;%server
Theta_c={};%client
Error=zeros(1,R);
for l=1:R

    %Initialize each client with \bar{\Theta}_0
    for i=1:M
        Theta_c{i}=Theta_s;
    end


    %Client side:
    for i=1:M

        if FL_solver==1

            %FedLin
 
            g=zeros(n,n+p);
            for s=1:M
                g=g-(X{s}-Theta_s*Z{s})*Z{s}';
            end
            g=(1/M)*g;
    
            for k=1:K
                Theta_c{i}=Theta_c{i} - (alpha)*(-(X{i}-Theta_c{i}*Z{i})*Z{i}'+(X{i}-Theta_s*Z{i})*Z{i}'+g);
            end
        
        elseif FL_solver==0

            %FedAvg
         
            for k=1:K
                Theta_c{i}=Theta_c{i} + (alpha/k)*((X{i}-Theta_c{i}*Z{i})*Z{i}');
            end
        end 

    end
    
    %Server side:
    Theta_sum=zeros(n,n+p);
    for i=1:M
        Theta_sum=Theta_sum + Theta_c{i};
    end
    Theta_s=(1/M)*Theta_sum;
 
    Error(l)=norm(Theta_s-[A{s} B{s}]);
end

end