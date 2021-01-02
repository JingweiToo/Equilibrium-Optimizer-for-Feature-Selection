
function [sFeat,Sf,Nf,curve] = jEO(feat,label,N,max_Iter,a1,a2,GP,HO)
% Parameters
lb    = 0;
ub    = 1; 
thres = 0.5; 

V     = 1;     % unit


fun = @jFitnessFunction; 

dim = size(feat,2); 

X   = zeros(N,dim); 
for i = 1:N
	for d = 1:dim
    X(i,d) = lb + (ub - lb) * rand(); 
  end
end

Xmb  = zeros(N,dim); 
fitM = ones(1,N);

fitE1 = inf;
fitE2 = inf; 
fitE3 = inf;
fitE4 = inf; 
Xeq1  = zeros(1,dim);
Xeq2  = zeros(1,dim); 
Xeq3  = zeros(1,dim);
Xeq4  = zeros(1,dim);
Xave  = zeros(1,dim);
fit   = zeros(1,N); 

curve = inf;
t = 1;

while t <= max_Iter
  
  for i = 1:N
    fit(i) = fun(feat,label,(X(i,:) > thres),HO);
  
    if fit(i) < fitE1
      fitE1 = fit(i); 
      Xeq1  = X(i,:);
    elseif fit(i) > fitE1 && fit(i) < fitE2
      fitE2 = fit(i);
      Xeq2  = X(i,:);
    elseif fit(i) > fitE1 && fit(i) > fitE2 && fit(i) < fitE3
      fitE3 = fit(i);
      Xeq3  = X(i,:);
    elseif fit(i) > fitE1 && fit(i) > fitE2 && fit(i) > fitE3 && ...
        fit(i) < fitE4
      fitE4 = fit(i);
      Xeq4  = X(i,:);
    end
  end

  for i = 1:N
    if fitM(i) < fit(i)
      fit(i) = fitM(i);
      X(i,:) = Xmb(i,:);
    end
  end

  Xmb  = X; 
  fitM = fit; 
 
  for d = 1:dim
    Xave(d) = (Xeq1(d) + Xeq2(d) + Xeq3(d) + Xeq4(d)) / 4;
  end
  
  Xpool = [Xeq1; Xeq2; Xeq3; Xeq4; Xave];
  
  T     = (1 - (t / max_Iter)) ^ (a2 * (t / max_Iter));
 
  for i = 1:N
   
    r1 = rand(); 
    r2 = rand();
    if r2 >= GP
      GCP = 0.5 * r1;
    else
      GCP = 0;
    end
  
    eq = randi([1,5]);
    for d = 1:dim
     
      r = rand();
    
      lambda = rand();
    
      F  = a1 * sign(r - 0.5) * (exp(-lambda * T) - 1);
      
      G0 = GCP * (Xpool(eq,d) - lambda * X(i,d));
     
      G  = G0 * F;
     
      X(i,d) = Xpool(eq,d) + (X(i,d) - Xpool(eq,d)) * F + ...
        (G / (lambda * V)) * (1 - F);
    end
    
    XB = X(i,:); XB(XB > ub) = ub; XB(XB < lb) = lb;
    X(i,:) = XB;
  end 
  curve(t) = fitE1;
  fprintf('\nIteration %d Best (EO)= %f',t,curve(t))
  t = t + 1;
end

Pos   = 1:dim; 
Sf    = Pos((Xeq1 > thres) == 1); 
sFeat = feat(:,Sf); 
Nf    = length(Sf); 

end



