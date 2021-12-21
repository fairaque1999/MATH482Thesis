function X_pred = DMDpredict(X, r, dt, pred_step)

% Function  to predict forward in time from the last snapshot of the data
% matrix

X1 = X(:, 1:end-1);
X2 = X(:, 2:end);

[Phi,omega,~,~,~,~] = DMD(X,r,dt);

% DMD Forecasting
iter = pred_step;
time_dynamics_pred = zeros(r, iter);
b_end = Phi\X2(:, end);
t = (0:iter-1)*dt;
for i = 1:iter
    time_dynamics_pred(:,i) = (b_end.*exp(omega*t(i)));
end
X_pred = Phi*time_dynamics_pred;
end