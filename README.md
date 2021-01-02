# Equilibrium Optimizer for Feature Selection

![Wheel](https://www.mathworks.com/matlabcentral/mlc-downloads/downloads/cdfbb2d9-cd8e-40d2-9cfe-8bca8d35643c/88757c26-126c-41dd-a4c7-c3cdc0a504d1/images/1597239329.PNG)

## Introduction
* This toolbox offers an Equilibrium Optimizer ( EO ) method 
* The < Main.m file > illustrates the example of how EO can solve the feature selection problem using benchmark data-set.

## Input
* *feat*     : feature vector ( Instances *x* Features )
* *label*    : label vector ( Instances *x* 1 )
* *N*        : number of particles
* *max_Iter* : maximum number of iterations
* *a1*       : Parameter 
* *a2*       : Parameter 
* *GP*       : Generation rate control parameter 


## Output
* *sFeat*    : selected features
* *Sf*       : selected feature index
* *Nf*       : number of selected features
* *curve*    : convergence curve


### Example
```code
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
```


## Requirement
* MATLAB 2014 or above
* Statistics and Machine Learning Toolbox


