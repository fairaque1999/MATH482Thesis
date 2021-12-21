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

iter = 500;
X = zeros(120, iter);

% % when we are saving the previous positions of the tracer particles
% for i=1:iter
%     [x_new, q_new, time_new, points] = l96_tracer_adv_1step(x, q, s, time, MODEL_FORCING, MODEL_OFFSET, MODEL_DT_ADD)
%     q = q_new;
%     x = x_new;
%     X(:, i) = [x_new q_new points];
% end
% writematrix(X,'test_source_new.csv') 

% when we are saving the source locations
for i=1:iter
    [x_new, q_new, time_new, points] = l96_tracer_adv_1step(x, q, s, time, MODEL_FORCING, MODEL_OFFSET, MODEL_DT_ADD)
    q = q_new;
    x = x_new;
    X(:, i) = [x_new q_new s];
end
writematrix(X,'test_source_new.csv') 