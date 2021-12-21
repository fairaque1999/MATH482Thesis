function X_pred = optDMDpredict(X, r, dt, t, pred_step)

% Need to add the optdmd source folder
addpath("../optdmd/src")

X1 = X(:, 1:end-1);
X2 = X(:, 2:end);

% t - times corresponding to each snapshot

[Phi,omega,~] = optdmd(X,t,r,1);

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