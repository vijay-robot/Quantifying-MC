% Plotting simdata values, this data is for Keyan's robot
f2 = figure;  % this allows both figures to be available simultaneously
load('simdata_201223.mat');
tiledlayout(5,1)
figure('Name','Sim MC Data','NumberTitle','off'); % will not print 'Figure 1, 2, etc. just name'

%position
ax1 = nexttile;
plot(ax1,position)
title(ax1,'Position')
ylabel(ax1,'m')

ax2 = nexttile;
plot(ax2,velocity)
title(ax2,'Velocity')
ylabel(ax2,'m/s')

ax3 = nexttile;
plot(ax3,accelaration)
title(ax3,'ACcleeration')
ylabel(ax3,'m/s2')



ax4 = nexttile;
plot(ax4,muscle_sensor)
title(ax4,'Sensor')
ylabel(ax4,'N')

ax5 = nexttile;
plot(ax5,action)
title(ax5,'Action')
ylabel(ax5,'V')