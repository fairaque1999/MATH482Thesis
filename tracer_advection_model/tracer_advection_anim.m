clear all; clc; close all

global DELTA_T
DELTA_T = 0.05;
global MODEL_SIZE;
MODEL_SIZE = 40;

MODEL_FORCING = 8.0;
MODEL_OFFSET = 0;
MODEL_DT_ADD = 0;

% Creating initial wind vector 
x(1:MODEL_SIZE) = 0;
x(1) = 1;

% Creating initial tracer vector
q(1:MODEL_SIZE) = 0;

% Creating initial source vector
s(1:MODEL_SIZE) = 0;
s(1) = 100;

% Starting at time 1
time = 1;

% How many iterations of model run to animate?
iter = 100;

mov = VideoWriter('lorenz96_new', 'MPEG-4');
open(mov)
l = 1;
figure('Name', 'Lorenz96','Color', 'white')

l = 1;
for i = 1:iter
   [x_new, q_new, time_new, points] = l96_tracer_adv_1step(x, q, s, time, MODEL_FORCING, MODEL_OFFSET, MODEL_DT_ADD);
   q = q_new;
   x = x_new;
   plot(x_new, 'LineWidth', 1.5);
   hold on
   plot(q_new, 'LineWidth', 1.5);
   hold on
   %The code below adds the locations of the tracers from semi-lag
   scatter(points, zeros(1,40), 'filled', 'MarkerFaceAlpha',.3);
   hold on
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   scatter(1, 0, 50, 'filled');
   %hold on
   %yline(0, '--', 'LineWidth', 1.5); 
   %hold on
   %scatter([1 20 40], [0 0 0], 50, 'LineWidth', 1.5);
   xlabel('Sites');
   ylabel('Wind/Tracer Concentration');
   hold off;
   axis(gca, [1 40 -10 25]);
   titlestring = sprintf('Tracers advecting in the Lorenz-96 wind');
   title(gca, titlestring);
   legend('Wind', 'Tracer', 'Source = 100/s', 'Ground Level')
   pause(0.4)
   M(l) = getframe(gcf);
   l = l + 1;  
end

open(mov)
writeVideo(mov, M)
close(mov)