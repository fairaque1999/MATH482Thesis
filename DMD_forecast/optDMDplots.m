%% Loading Data

M =  readmatrix('test_source_1.csv');

%% Training with 300 steps

% Select the first 300 timesteps, and the first 80 rows (optDMD)
X_sel300 = M(1:80, 1:300);
t300 = 0:0.05:14.95; % need the timesetps for optDMD
% Setting up the two figures for heatmaps
close all;
wind_fig300 = figure;
conc_fig300 = figure;

% Creating the prediction matrix
X_pred300 = optDMDpredict(X_sel300, 30, 0.05, t300, 50);
X_mat300 = [X_sel300 real(X_pred300)];
X_true300 = M(1:80, 1:350);


% Now creating the heatmaps (Wind)
figure(wind_fig300)
colormap(winter)

subplot(2,1,1)
imagesc(X_true300(1:40, :))
xlabel("Timesteps")
ylabel("Model Grids")
title("True State of the Model for 350 Timesteps")
c = colorbar;
c.Label.String = 'Wind Values'

subplot(2,1,2)
imagesc(X_mat300(1:40, :))
xline(300, '-r', 'LineWidth', 1.5)
xlabel("Timesteps")
ylabel("Model Grids")
title("DMD Training Data and DMD Forecast")
text(150,20,"Training Data", 'Color', 'white', 'FontWeight','bold')
text(303,20,"Prediction", 'Color', 'white', 'FontWeight','bold')
c = colorbar;
c.Label.String = 'Wind Values'



% Now creating the heatmaps (Concentration)
figure(conc_fig300)
colormap(parula)

subplot(2,1,1)
imagesc(X_true300(41:80, :))
xlabel("Timesteps")
ylabel("Model Grids")
title("True State of the Model for 350 Timesteps")
c = colorbar;
c.Label.String = 'Tracer Conc. Values';

subplot(2,1,2)
imagesc(X_mat300(41:80, :))
xline(300, '-r', 'LineWidth', 1.5)
xlabel("Timesteps")
ylabel("Model Grids")
title("DMD Training Data and DMD Forecast")
text(150,20,"Training Data", 'Color', 'white', 'FontWeight','bold')
text(303,20,"Prediction", 'Color', 'white', 'FontWeight','bold')
c = colorbar;
c.Label.String = 'Tracer Conc. Values';

% saveas(wind_fig300, "wind_fig300_optDMD.png")
% saveas(conc_fig300, "conc_fig300_optDMD.png")

windsite_fig300 = figure;
concsite_fig300 = figure;

% Now creating a site specific wind prediction figure

figure(windsite_fig300)
plot(301:350, real(X_pred300(15, :)), 'r-', 'LineWidth',1.5)
hold on
plot(251:350, X_true300(15, 251:350), 'b.', 'MarkerSize',8)
title("optDMD Prediction of Lorenz-96 Wind at Site 15")
xlabel("Timesteps")
ylabel("Lorenz-96 Wind Value")
legend("DMD Forecast", "Model Data")

% Now creating a site specific conc. prediction figure
figure(concsite_fig300)
plot(301:350, real(X_pred300(73, :)), 'r-', 'LineWidth',1.5)
hold on
plot(251:350, X_true300(73, 251:350), 'b.', 'MarkerSize',8)
title("optDMD Prediction of Tracer Concentration at Site 33")
xlabel("Timesteps")
ylabel("Tracer Concentration")
legend("DMD Forecast", "Model Data")


% saveas(windsite_fig300, "windsite_fig300_optDMD.png")
% saveas(concsite_fig300, "concsite_fig300_optDMD.png")


%% Training with 500 steps

% Select the first 500 timesteps, and the first 80 rows (opt DMD)
X_sel500 = M(1:80, 1:500);
t500 = 0:0.05:24.95;
% Setting up the two figures for heatmaps
close all;
wind_fig500 = figure;
conc_fig500 = figure;

% Creating the prediction matrix
X_pred500 = optDMDpredict(X_sel500, 30, 0.05, t500, 50);
X_mat500 = [X_sel500 real(X_pred500)];
X_true500 = M(1:80, 1:550);


% Now creating the heatmaps (Wind)
figure(wind_fig500)
colormap(winter)

subplot(2,1,1)
imagesc(X_true500(1:40, :))
xlim([200, 550])
xlabel("Timesteps")
ylabel("Model Grids")
title("True State of the Model for 550 Timesteps")
c = colorbar;
c.Label.String = 'Wind Values'

subplot(2,1,2)
imagesc(X_mat500(1:40, :))
xlim([200, 550])
xline(500, '-r', 'LineWidth', 1.5)
xlabel("Timesteps")
ylabel("Model Grids")
title("DMD Training Data and DMD Forecast")
text(350,20,"Training Data", 'Color', 'white', 'FontWeight','bold')
text(503,20,"Prediction", 'Color', 'white', 'FontWeight','bold')
c = colorbar;
c.Label.String = 'Wind Values'




% Now creating the heatmaps (Concentration)
figure(conc_fig500)
colormap(parula)

subplot(2,1,1)
imagesc(X_true500(41:80, :))
xlim([200, 550])
xlabel("Timesteps")
ylabel("Model Grids")
title("True State of the Model for 550 Timesteps")
c = colorbar;
c.Label.String = 'Tracer Conc. Values';

subplot(2,1,2)
imagesc(X_mat500(41:80, :))
xlim([200, 550])
xline(500, '-r', 'LineWidth', 1.5)
xlabel("Timesteps")
ylabel("Model Grids")
title("DMD Training Data and DMD Forecast")
text(350,20,"Training Data", 'Color', 'white', 'FontWeight','bold')
text(503,20,"Prediction", 'Color', 'white', 'FontWeight','bold')
c = colorbar;
c.Label.String = 'Tracer Conc. Values';

% saveas(wind_fig500, "wind_fig500_optDMD.png")
% saveas(conc_fig500, "conc_fig500_optDMD.png")

windsite_fig500 = figure;
concsite_fig500 = figure;

% Now creating a site specific wind prediction figure

figure(windsite_fig500)
plot(501:550, real(X_pred500(15, :)), 'r-', 'LineWidth',1.5)
hold on
plot(451:550, X_true500(15, 451:550), 'b.', 'MarkerSize',8)
title("optDMD Prediction of Lorenz-96 Wind at Site 15")
xlabel("Timesteps")
ylabel("Lorenz-96 Wind Value")
legend("DMD Forecast", "Model Data")

% Now creating a site specific conc. prediction figure
figure(concsite_fig500)
plot(501:550, real(X_pred500(73, :)), 'r-', 'LineWidth',1.5)
hold on
plot(451:550, X_true500(73, 451:550), 'b.', 'MarkerSize',8)
title("optDMD Prediction of Tracer Concentration at Site 33")
xlabel("Timesteps")
ylabel("Tracer Concentration")
legend("DMD Forecast", "Model Data")


% saveas(windsite_fig500, "windsite_fig500_optDMD.png")
% saveas(concsite_fig500, "concsite_fig500_optDMD.png")


%% Training with 1000 steps

% Select the first 500 timesteps, and the first 80 rows (non-lagrangian DMD)
X_sel1000 = M(1:80, 1:1000);
t1000 = 0:0.05:49.95;
% Setting up the two figures for heatmaps
close all;
wind_fig1000 = figure;
conc_fig1000 = figure;

% Creating the prediction matrix
X_pred1000 = optDMDpredict(X_sel1000, 30, 0.05, t1000, 50);
X_mat1000 = [X_sel1000 real(X_pred1000)];
X_true1000 = M(1:80, 1:1050);


% Now creating the heatmaps (Wind)
figure(wind_fig1000)
colormap(winter)

subplot(2,1,1)
imagesc(X_true1000(1:40, :))
xlim([700, 1050])
xlabel("Timesteps")
ylabel("Model Grids")
title("True State of the Model for 1050 Timesteps")
c = colorbar;
c.Label.String = 'Wind Values'

subplot(2,1,2)
imagesc(X_mat1000(1:40, :))
xlim([700, 1050])
xline(1000, '-r', 'LineWidth', 1.5)
xlabel("Timesteps")
ylabel("Model Grids")
title("DMD Training Data and DMD Forecast")
text(850,20,"Training Data", 'Color', 'white', 'FontWeight','bold')
text(1003,20,"Prediction", 'Color', 'white', 'FontWeight','bold')
c = colorbar;
c.Label.String = 'Wind Values'



% Now creating the heatmaps (Concentration)
figure(conc_fig1000)
colormap(parula)

subplot(2,1,1)
imagesc(X_true1000(41:80, :))
xlim([700, 1050])
xlabel("Timesteps")
ylabel("Model Grids")
title("True State of the Model for 1050 Timesteps")
c = colorbar;
c.Label.String = 'Tracer Conc. Values';

subplot(2,1,2)
imagesc(X_mat1000(41:80, :))
xlim([700, 1050])
xline(1000, '-r', 'LineWidth', 1.5)
xlabel("Timesteps")
ylabel("Model Grids")
title("DMD Training Data and DMD Forecast")
text(850,20,"Training Data", 'Color', 'white', 'FontWeight','bold')
text(1003,20,"Prediction", 'Color', 'white', 'FontWeight','bold')
c = colorbar;
c.Label.String = 'Tracer Conc. Values';

saveas(wind_fig1000, "wind_fig1000_optDMD.png")
saveas(conc_fig1000, "conc_fig1000_optDMD.png")

windsite_fig1000 = figure;
concsite_fig1000 = figure;

% Now creating a site specific wind prediction figure

figure(windsite_fig1000)
plot(1001:1050, real(X_pred1000(15, :)), 'r-', 'LineWidth',1.5)
hold on
plot(951:1050, X_true1000(15, 951:1050), 'b.', 'MarkerSize',8)
title("optDMD Prediction of Lorenz-96 Wind at Site 15")
xlabel("Timesteps")
ylabel("Lorenz-96 Wind Value")
legend("DMD Forecast", "Model Data")

% Now creating a site specific conc. prediction figure
figure(concsite_fig1000)
plot(1001:1050, real(X_pred1000(73, :)), 'r-', 'LineWidth',1.5)
hold on
plot(951:1050, X_true1000(73, 951:1050), 'b.', 'MarkerSize',8)
title("optDMD Prediction of Tracer Concentration at Site 33")
xlabel("Timesteps")
ylabel("Tracer Concentration")
legend("DMD Forecast", "Model Data")

% saveas(windsite_fig1000, "windsite_fig1000_optDMD.png")
% saveas(concsite_fig1000, "concsite_fig1000_optDMD.png")
