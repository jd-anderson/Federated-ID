% ==========================================================================
% FedSysID: A Federated Approach to Sample-Efficient System Identification
% Han Wang, Leonardo F. Toso, James Anderson
% ==========================================================================

clc;clear all; close all


%% System Data:

% System dimensions

n=3;
p=2;

% Nominal system: 

A_0=[0.6 0.5 0.4;
     0   0.4 0.3;
     0    0  0.3];

B_0=[1   0.5;
     0.5   1;
     0.5  0.5];

V=[0 0 0;0 1 0;0 0 1]; %Modification pattern applied to A_0
U=[1 0;0 0;0 1]; % Modification pattern applied to B_0

% noise level, input singal and initial state
sigu = 1;
sigw = 1;
sigx = 1;

%Rollout length:

T=5;


%Sellecting the FL_solver: Fed_Avg (FL_solver = 0) and Fed_Lin (FL_solver = 1)

FL_solver = 0; 

q=25; %number of estimations
R=200; %number of global iterations
s=1; %fixed system for the error computation


%% Simulation 1: varying M

%Number of clients

M=[1 2 5 25 100];

%Fixed number of rollouts:

N=25;

%Fixed dissimilarity

delta=0.01;


% Generating the system matrices:
% We can generate M system matrices (A(i),B(i)) for A_0 and B_0, 
% such that max i,j∈[M] ∥[A(i) − A(j), B(i) − B(j) ]∥ ≤ δ.

[A,B] = sysgen(A_0,B_0,V,U,M,delta); % This function generates similar systems

E_avg=zeros(length(M),R);

%% Numerical results varying the number of clients participating in the collaboration

Error_matrix=zeros(q,R);
    for j=1:length(M)
        for i=1:q
            [Error_matrix(i,:)] = sysid(A,B,T,N,M(j),R,sigu,sigx,sigw,FL_solver,s);
        end
        E_avg(j,:)=mean(Error_matrix);
    end

S1=E_avg;



%% Simulation 2: varying N


%Fixed number of clients:

M=50;

%Number of rollouts:

N=[5 25 50 75 100];

% Here we set delta = 0.01

%% Numerical results varying the number of rollouts

    for j=1:length(N)
        for i=1:q
            [Error_matrix(i,:)] = sysid(A,B,T,N(j),M,R,sigu,sigx,sigw,FL_solver,s);
        end
        E_avg(j,:)=mean(Error_matrix);
    end

 S2=E_avg;



%% Simulation 3: varying delta

%Fixed number of clients:

M=50;

%Fixed number of rollouts:

N=25;

%Dissimilarity

delta=[0.01 0.1 0.25 0.5 0.75];

%% Numerical results for different number of rollouts

    for j=1:length(delta)
        
        [A,B] = sysgen(A_0,B_0,V,U,M,delta(j));

        for i=1:q
            [Error_matrix(i,:)] = sysid(A,B,T,N,M,R,sigu,sigx,sigw,FL_solver,s);
        end
        E_avg(j,:)=mean(Error_matrix);
    end

S3=E_avg;


%% Illustrating the numerical results:

if FL_solver==0
    title_fig='FedAvg';
elseif FL_solver==1
    title_fig='FedLin';
end

% Error vs number of global iterations - verying M
figure(1);
M=[1 2 5 25 100];
ax = axes;
ax.ColorOrder = [0 0.4470 0.7410;0.4940 0.1840 0.5560;0.8500 0.3250 0.0980;0.9290 0.6940 0.1250;0.1 0.1 0.1];
hold on
for i=1:length(M)
   plot(1:1:R,S1(i,:),'LineWidth',1.2);
end
hold off
legend(strcat('$M=$',num2str(M')),'Interpreter','latex');
xlab=xlabel('r','Interpreter','latex');
ylab=ylabel('$e_r$','Interpreter','latex');
set(xlab,'FontSize',20);
set(ylab,'FontSize',20);
set(gca,'FontSize',20)
xlim([1 R]) 
grid on; box
title(title_fig)

% Error vs number of global iterations - verying N
figure(2);
N=[5 25 50 75 100];
ax = axes;
ax.ColorOrder = [0 0 1;0 0.5 0;1 0 0;0 0.75 0.75;0.75 0.5 0.75];
hold on
for i=1:length(N)
   plot(1:1:R,S2(i,:),'LineWidth',1.2);
end
hold off
legend(strcat('$N_i=$',num2str(N')),'Interpreter','latex');
xlab=xlabel('r','Interpreter','latex');
ylab=ylabel('$e_r$','Interpreter','latex');
set(xlab,'FontSize',20);
set(ylab,'FontSize',20);
set(gca,'FontSize',20)
xlim([1 R]) 
grid on; box
title(title_fig)

% Error vs number of global iterations - verying delta
figure(3);
delta=[0.01 0.1 0.25 0.5 0.75];
ax = axes;
ax.ColorOrder = [0.2 0.1 1;0.3 0.6 0.1;0.9 0.5 0;0.5 0.9 0.9;0.6 0.5 0.6];
hold on
for i=1:length(delta)
   plot(1:1:R,S3(i,:),'LineWidth',1.2);
end
hold off
legend(strcat('$\delta=$',num2str(delta')),'Interpreter','latex');
xlab=xlabel('r','Interpreter','latex');
ylab=ylabel('$e_r$','Interpreter','latex');
set(xlab,'FontSize',20);
set(ylab,'FontSize',20);
set(gca,'FontSize',20)
xlim([1 R]) 
grid on; box
title(title_fig)

