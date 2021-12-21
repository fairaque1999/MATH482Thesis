% Test harness for tracer advection in L96
clear all; clc; close all

global DELTA_T
DELTA_T = 0.05;
global MODEL_SIZE;
MODEL_SIZE = 40;

MODEL_FORCING = 8.0;
MODEL_OFFSET = 0;
MODEL_DT_ADD = 0;


x(1:MODEL_SIZE) = 0;
x(1) = 1;

q(1:MODEL_SIZE) = 0;

time = 1;
% for i = 1:1000
%    i
%    [x_new, q_new, time_new] = l96_tracer_adv_1step(x, q, time, MODEL_FORCING, MODEL_OFFSET, MODEL_DT_ADD);
%    q = q_new
%    x = x_new
%    q_plot(1:40) = q_new;
%    q_plot(41:80) = q_new;
%    figure(1)
%    plot(q_plot, 'b');
%    title(i)
%    axis([0 80 0 8]);
%    figure(2)
%    plot(x_new, 'r')
%    pause(0.05)
% 
% end
%[x_new, q_new, time_new, points] = l96_tracer_adv_1step(x, q, time, MODEL_FORCING, MODEL_OFFSET, MODEL_DT_ADD)
% 
% sources = zeros(1,40)
% sources(20) = 100
% 
% x = [x_new q_new sources points]
% 
% writematrix(x','test_source_20.csv') 

% mov = VideoWriter('lorenz96', 'MPEG-4');
% open(mov)
% l = 1;
% figure('Name', 'Lorenz96','Color', 'white')
% 
% l = 1;
% for i = 1:500
%    [x_new, q_new, time_new, points] = l96_tracer_adv_1step(x, q, time, MODEL_FORCING, MODEL_OFFSET, MODEL_DT_ADD);
%    q = q_new
%    x = x_new
%    plot(x_new, 'LineWidth', 1.5);
%    hold on
%    plot(q_new, 'LineWidth', 1.5);
%    hold on
%    %The code below adds the locations of the tracers from semi-lag
%    %scatter(points, zeros(1,40), 'filled', 'MarkerFaceAlpha',.3);
%    %hold on
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    scatter(1, 0, 50, 'filled');
%    %hold on
%    %yline(0, '--', 'LineWidth', 1.5); 
%    %hold on
%    %scatter([1 20 40], [0 0 0], 50, 'LineWidth', 1.5);
%    xlabel('Sites');
%    ylabel('Wind/Tracer Concentration');
%    hold off;
%    axis(gca, [1 40 -10 25]);
%    titlestring = sprintf('Tracers advecting in the Lorenz-96 wind');
%    title(gca, titlestring);
%    legend('Wind', 'Tracer', 'Source = 100/s', 'Ground Level')
%    pause(0.4)
%    M(l) = getframe(gcf);
%    l = l + 1;  
% end
% 
% open(mov)
% writeVideo(mov, M)
% close(mov)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TESTING/EXPLORING DYNAMIC MODES 
iter = 2000
X = zeros(120, iter)

for i=1:iter
    [x_new, q_new, time_new, points] = l96_tracer_adv_1step(x, q, time, MODEL_FORCING, MODEL_OFFSET, MODEL_DT_ADD)
    q = q_new;
    x = x_new;
    X(:, i) = [x_new q_new points]
end

writematrix(X,'test_source_1.csv') 
%%
% X_sel = X(:, 1:200);
% [u,s,v] = svd(X_sel);

%plot(diag(s)/sum(diag(s)), 'ro')
% 5 are separate from the others hold around 65 percent of variance, around
% 33 dynamic modes hold the majority


    