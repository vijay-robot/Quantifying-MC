% Plotting realdata values from tyhe structured field 'realfiles'
cla;
%this data is for the physical robot with 3 mm blade
f1 = figure; % this allows all figures to be available simultaneously
load('simdata_201223.mat');
tiledlayout(5,1)
figure('Name','Real Data b2_3mm','NumberTitle','off'); % will not print 'Figure 1, 2, etc. just name'
title('Real Data Blade 5 mm')
xarray = [0 5500]; %limit data
%position

realfiles_b2_3.smooth_gaussian = smoothdata(realfiles_b2_3.mcd,'gaussian');
realfiles_b2_3.smooth_golay = smoothdata(realfiles_b2_3.mcd,'sgolay');
realfiles_b2_3.smooth_gaussian2 = realfiles_b2_3.smooth2_mcd(1500:end,:); %adjustment to capture proper cycle
realfiles_b2_3.Ztip2 = realfiles_b2_3.Ztip(500:end,:);%adjustment to capture proper gait cycle

%plotting begins 
%1 Plot 1 - 3 plots
ax1 = nexttile;

yyaxis left;
plot(ax1,realfiles_b2_3.smooth_gaussian2, 'b')
%plot(ax1,filtfilt(d1,realfiles_b2.smooth_gaussian))
xlim(ax1,xarray);
ylabel(ax1,'Morphological Computation')
xlabel(ax1, 'Time (s)')
%%right axis, two plots Power and Force
yyaxis right;
hold on;
plot(ax1, realfiles_b2_3.ForceCalc,'color' ,[0.4660 0.6740 0.188]); %square brackets for RGB triplets, dark green
%ylabel(ax1,{'\color{red} Instantaneous Power Consumptionm (W)';'\color[rgb]{0.4660 0.6740 0.188} Ground Reaction Force (N)'});
ylabel(ax1,{'\color[rgb]{0.4660 0.6740 0.188} Ground Reaction Force (N)'});

xticks(0:500:5500)
xt = get(gca, 'XTick');
set(gca, 'XTick',xt, 'XTickLabel',xt/1000) % to show in seconds

ax2 = nexttile;
xlim(ax2,xarray);
yyaxis left
plot(ax2,smoothdata(realfiles_b2_3.smooth_gaussian2,'movmedian',70),'b');
ylim(ax2,[0 10]);
%yticks(ax2,0:1:10);
%plot(ax2,realfiles_b2.smooth_gaussian2, 'b')
%title(ax2,'Velocity')
ylabel(ax2,'Morphological Computation Blade 3 mm')

yyaxis right

% plot(ax2,realfiles_b2.Ztip2);

% hold on;
plot(ax2, smoothdata(realfiles_b2_3.ForceCalc,'movmedian',50))
ylabel(ax2,{'Ground Reaction Force (N)'});
xlabel(ax2, 'Time (s)');
ylim(ax2,[0 1]);
%yticks(ax2, [0:0.1:1]);
xt = get(gca, 'XTick');
set(gca, 'XTick',xt, 'XTickLabel',xt/1000) %to show in seconds

ax3 = nexttile;

% plot(ax3,smoothdata(abs(realfiles.Hvelocity)));
xlim(ax3,xarray);
yyaxis left;
plot(ax3, smoothdata(realfiles_b2_3.Hcurrent,'movmedian',70));
ylabel(ax3, 'Hip Current');
yyaxis right;
plot(ax3, smoothdata(realfiles_b2_3.Kcurrent,'movmedian',70));
ylabel(ax3, 'Knee Current');

ax4= nexttile;

yyaxis left;
plot(ax4,smoothdata(realfiles_b2_3.MechPower,'movmedian',70));
xlim(ax4,xarray);
ylabel(ax4,'Instantaneous Power Consumption (W)');

yyaxis right
hold on;
plot(ax4,realfiles_b2_3.Ztip2*430/330);
ylabel (ax4, 'Z axis Position');

ax5 = nexttile;

yyaxis left;
plot(ax5,smoothdata(realfiles_b2_3.MechPower,'movmedian',70));
xlim(ax5,xarray);
ylabel(ax5,'Instantaneous Power Consumption (W)');

yyaxis right
hold on;
plot(ax5,smoothdata(realfiles_b2_3.MotorLoss,'movmedian',70));
ylabel (ax5, 'Motor Losses');
%% Calculations

E_b2_3 = trapz(realfiles_b2_3.MechPower);
Xb2_3_min = min(realfiles_b2_3.Xtip);
Xb2_3_max = max(realfiles_b2_3.Xtip);
Xb2_dist_3mm = (Xb2_3_max - Xb2_3_min)*8.0; %8 cycles
COT_Xb2_3mm = E_b2_3/(mass*gr*Xb2_dist_3mm);


