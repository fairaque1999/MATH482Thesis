%%
M = readmatrix('test_source_1.csv');
colormap(winter)
X_sel = M(1:80, 1:300);

subplot(2,1,1)
imagesc(M(1:80, 1:350))
colorbar

% X_pred = DMD4cast(X_sel,40, 0.05, 50)
%[~,~,~,~,~,~,X_pred] = DMDedit(X_sel, 45, 0.05,50)
t = 0:0.05:14.95;
X_pred = optDMDpredict(X_sel, 30, 0.05, t, 50);
% X_pred = DMDpredict(X_sel, 40, 0.05,50);
% select the prediction steps
%X_pred_step = X_pred(:, 200:250)
% 
% plot(301:350, real(X_pred(73,1:50)), 'r-')
% hold on
% plot(201:350, M(73, 201:350), 'b.')
X_p = [X_sel real(X_pred)];
% figure
subplot(2,1,2)
imagesc(X_p)
colorbar

%%

xi = linspace(-10,10,400) ; 
t = linspace(0,4*pi,200);

dt = t(2) - t(1);

[Xgrid ,T] = meshgrid(xi,t); 

f1 = sech(Xgrid+3) .* (1*exp(1j*2.3*T)); 
f2 = (sech(Xgrid).*tanh(Xgrid)).*(2*exp(1j*2.8*T));
f = f1 + f2;
X = f'; % Data Matrix

[~,~,~,~,X_recon,~] = DMDedit(X, 5, 0.05, 100)
% [~,~,~,~,~,~,X_pred] = DMDedit(X, 2, dt, 50)
X_pred = optDMDpredict(X, 2, 0.05, t, 50);
% 
% % X_pred = DMD4cast(X(:, 1:100),2, dt, 50)
% 
plot(real(X_recon(30,1:100)), 'r-')
hold on
plot(real(X(30, 1:149)), 'b.')
hold on
plot(100:149, X_pred(30, :), 'r--')

% [~,~,~,~,X_pred,~] = DMDedit(X, 2, 0.05, 100)

%[~,~,~,~,A] = DMDedit(X_sel, 35, 0.05)



