function[x_new, q_new, time_new, target_points] = l96_tracer_adv_1step(x, q, s, time, forcing, offset, dt_add)
% lorenz_96_adv_1step Does a single time step advance for lorenz_96 MODEL_SIZE-variable 
% model using four step runge-kutta time step
% Add in an offset to study observation bias in the presence of simpler model bias
%
% x is the MODEL_SIZE-vector state, time is the 2-vector days and seconds time

% This version also has a tracer q that is moved about by upstream semi-lagrangian advection 
% along with a point source and a uniform global sink
% s is a vector the same size as s and q that describes the location and
% strength of sources in the model

global DELTA_T
global MODEL_SIZE


% Parameters for the tracer; Will want these as arguments eventually, or global
% Mean velocity
MEAN_VELOCITY = 25;
% Velocity normalization
PERT_VELOCITY_MULTIPLIER= 5;
% Diffusion everywhere
DIFFUSION_COEFFICIENT = 0.0;
% Have an exponential sink
E_FOLDING = 1;

% Do upstream semi-lagrangian advection for q for each grid point
for i = 1:MODEL_SIZE
   % Get target point
   velocity = MEAN_VELOCITY + x(i) * PERT_VELOCITY_MULTIPLIER;
   target = i - velocity*DELTA_T;
   % Get the bounding gridpoints
   low = floor(target);
   hi = low + 1;
   frac = target - low;
   % Assume for now that we're not looking upstream for multiple revolutions
   if(low < 1) 
      low = low + MODEL_SIZE;
   elseif(low > MODEL_SIZE) 
      low = low - MODEL_SIZE;
   end
   if(hi < 1) 
      hi = hi + MODEL_SIZE;
   elseif(hi > MODEL_SIZE) 
      hi = hi - MODEL_SIZE;
   end

   % Initial try, just do straight interpolation
   q_new(i) = (1 - frac) * q(low) + frac * q(hi);
   % saving the previous position of the interpolated tracer particle to be
   % used for the lagrangian DMD
   target_points(i) = low+frac
   
end

% Do some diffusion to smooth things out to avoid shocky behavior. SL is already doing some of this.
% Try a 1-2-1 smoother at the end
for i = 1:MODEL_SIZE
   down = i - 1;
   if(down < 1) down = down + MODEL_SIZE; end
   up = i + 1;
   if(up > MODEL_SIZE) up = up - MODEL_SIZE; end
   q_diff(i) = DIFFUSION_COEFFICIENT * (q_new(down) + q_new(up) -2*q_new(i));
end
q_new = q_new + DELTA_T * q_diff;

% Add effects from sources to q according to the structure of vector s
q_new = q_new + s*DELTA_T;

% SINK: Damp everywhere by some amount
ratio = exp(-E_FOLDING * DELTA_T);
q_new = ratio * q_new;

% Do the 'standard L96 Variables' (Solving the system of differential 
%  equations using the 4th Order Runge-Kutte Method)

% Do an offset of x before computing
x = x - offset;

% Compute first intermediate step
dx = comp_dt(x, forcing);
x1 = DELTA_T * dx;
inter = x + x1 / 2;

% Compute second intermediate step
dx = comp_dt(inter, forcing);
x2 = DELTA_T * dx;
inter = x + x2 / 2;

% Compute third intermediate step
dx = comp_dt(inter, forcing);
x3 = DELTA_T * dx;
inter = x + x3;

% Compute fourth intermediate step
dx = comp_dt(inter, forcing);
x4 = DELTA_T * dx;

% Compute new value for x
x_new = x + x1/6 + x2/3 + x3/3 + x4/6;

% Add back in the offset to the final state
x_new = x_new + offset;

% Increment time step
time_new = time + 1;

% Put in an additive bump to the x_new
x_new = x_new + dt_add;

end

%------------------------------------------------------------------------------
% Function to define the equations for the Lorenz-96 model
function[dt] = comp_dt(x,forcing)

global MODEL_SIZE

dt = zeros(1,MODEL_SIZE);

for j = 1:MODEL_SIZE
   jp1 = j + 1;
   if(jp1 > MODEL_SIZE), jp1 = 1; end

   jm2 = j - 2;
   if(jm2 < 1), jm2 = MODEL_SIZE + jm2; end

   jm1 = j - 1;
   if(jm1 < 1), jm1 = MODEL_SIZE; end

   dt(j) = (x(jp1) - x(jm2)) * x(jm1) - x(j) + forcing;
end

end
