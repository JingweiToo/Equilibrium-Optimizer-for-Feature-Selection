%--------------------------------------------------------------------%
%  Equilibrium Optimizer (EO) source codes demo version              %
%--------------------------------------------------------------------%


%---Inputs-----------------------------------------------------------
% feat     : feature vector ( Instances x Features )
% label    : label vector ( Instances x 1 )
% N        : Number of particles
% max_Iter : Maximum number of iterations
% a1       : Parameter 
% a2       : Parameter 
% GP       : Generation rate control parameter 

%---Output-----------------------------------------------------------
% sFeat    : Selected features (instances x features)
% Sf       : Selected feature index
% Nf       : Number of selected features
% curve    : Convergence curve
%--------------------------------------------------------------------


%% Equilibrium Optimizer
clc, clear, close; 
% Benchmark data set 
load ionosphere.mat; 

% Set 20% data as validation set
ho = 0.2; 
% Hold-out method
HO = cvpartition(label,'HoldOut',ho);

% Parameter setting
N        = 10; 
max_Iter = 100;
a1       = 2;      % constant
a2       = 1;      % constant
GP       = 0.5;    % generation probability 

% Equilibrium Optimizer
[sFeat,Sf,Nf,curve] = jEO(feat,label,N,max_Iter,a1,a2,GP,HO);

% Plot convergence curve
plot(1:max_Iter,curve);
xlabel('Number of iterations');
ylabel('Fitness Value');
title('EO'); grid on;




