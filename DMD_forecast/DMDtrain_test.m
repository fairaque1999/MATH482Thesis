%%
M =  readmatrix('test_source_1.csv');
% Training with 300 steps

% Select the first 300 timesteps, and the first 80 rows (non-lagrangian DMD)
X_sel300 = M(41:120, 1:300);
[u,s,v] = svd(X_sel300);
figure
plot(diag(s)/sum(diag(s)), 'b.-', 'MarkerSize',7)
xlabel("Dynamic Modes")
ylabel("Fraction of Variance")
%%

% Setting up the two figures for heatmaps
close all;
wind_fig300 = figure;
conc_fig300 = figure;

% Creating the prediction matrix
X_pred300 = DMDpredict(X_sel300, 15, 0.05, 50);
X_mat300 = [X_sel300 real(X_pred300)];
X_true300 = M(41:120, 1:350);

% subplot(2,1,1)
% imagesc(X_true300(1:40, :))
% xlabel("Timesteps")
% ylabel("Model Grids")
% title("True State of the Model for 350 Timesteps")
% c = colorbar;
% c.Label.String = 'Wind Values'
% 
% subplot(2,1,2)
% imagesc(X_mat300(1:40, :))
% xline(300, '-r', 'LineWidth', 1.5)
% xlabel("Timesteps")
% ylabel("Model Grids")
% title("DMD Training Data and DMD Forecast")
% c = colorbar;
% c.Label.String = 'Wind Values'

figure
plot(301:350, real(X_pred300(10, :)), 'r-', 'LineWidth',1.5)
hold on
plot(251:350, X_true300(10, 251:350), 'b.', 'MarkerSize',8)
title("DMD Prediction of Lorenz-96 Wind at Site 15")
xlabel("Timesteps")
ylabel("Lorenz-96 Wind Value")
legend("DMD Forecast", "Model Data")
