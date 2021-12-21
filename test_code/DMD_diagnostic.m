% Load the required dataset
M = readmatrix('test_source_1.csv');


%% Looking at the dynamic modes of the entire data, including the previous
% tracer positions (Lagrangian DMD)
lagDMDmode = figure;
figure(lagDMDmode)
X_sel = M(:, 1:1000);
[u,s,v] = svd(X_sel);
plot(diag(s)/sum(diag(s)), 'b.-', 'MarkerSize',7)
xlabel("Dynamic Modes")
ylabel("Fraction of Variance")
title("Dynamic modes for the Lagrangian DMD setup")
% 5 are separate from the others hold around 65 percent of variance, around
% 30 dynamic modes hold the majority
saveas(lagDMDmode, "lagDMDmode.png")

%% Looking at the dynamic modes of the data excluding the previous tracer
% positions
DMDmode = figure;
figure(DMDmode)
X_sel = M(1:80, 1:1000);
[u,s,v] = svd(X_sel);
plot(diag(s)/sum(diag(s)), 'r.-', 'MarkerSize',7)
xlabel("Dynamic Modes")
ylabel("Fraction of Variance")
title("Dynamic modes for the standard DMD setup")
saveas(DMDmode, "DMDmode.png")