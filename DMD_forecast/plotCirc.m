function plotCirc(x,y,r)
% calculate "points" where you want to draw approximate a circle
ang = 0:0.01:2*pi+.01; 
xp = r*cos(ang);
yp = r*sin(ang);
% plot with color: b-blue
plot(x+xp,y+yp,'--k', 'LineWidth', 1.5); 
end