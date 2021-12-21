% DMD Modes
M =  readmatrix('test_source_1.csv');

% Select the first 300 timesteps, and the first 80 rows (non-lagrangian DMD)
X_sel300 = M(1:80, 1:300);

[Phi,omega,lambda,b,A,Xdmd] = DMD(X_sel300(1:80, :),45,0.05)

figure
plot(real(Phi(:,1)),'LineWidth',1.5)
hold on 
plot(real(Phi(:,3)), 'LineWidth',1.5)
hold on 
plot(real(Phi(:,5)), 'LineWidth',1.5)
legend("mode 1", "mode 3", "mode 5")
title("Spatial Modes of Tracer Concentrations")
ylabel("Tracer Concentraion Values")
xlabel("Model Grids")
% plot(omega, 'r.')
% hold on

figure
axis square
plotCirc(0,0,1)
xlim([-1.2,1.2])
ylim([-1.2,1.2])
hold on
plot(lambda, 'b.', 'MarkerSize', 8)
title("Eigenvalues (\Lambda)")
xlabel("real(\lambda)")
ylabel("imag(\lambda)")

