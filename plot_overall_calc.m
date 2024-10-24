%% Overall calculations
fn4 = realfiles_b2_4.mcd;;
COT_array = [COT_Xn COT_Xb2_5mm COT_Xb2_4mm COT_Xb2_3mm COT_Xb2];
MC_array = [realfiles.mcw  realfiles_b2_5.mcw*0.8  realfiles_b2_4.mcw realfiles_b2_3.mcw realfiles_b2.mcw];
%f4 = figure;
std_array = [std(fn) std(fn5) std(fn4) std(fn3) std(fn2)];
%yyaxis left;
X_cot = categorical({'Standard Leg','Blade 5 mm','Blade 4 mm', 'Blade 3 mm', 'Blade 2 mm'});
X_cotR = reordercats(X_cot, ({'Standard Leg','Blade 5 mm','Blade 4 mm','Blade 3 mm', 'Blade 2 mm'}));
bar(X_cotR,COT_array, 0.4, 'c');
ylabel ('COT', 'FontSize',14)


%% 
bar(X_cotR,MC_array,0.4, 'g')
hold on
errorbar(X_cotR,MC_array,std_array);
ylabel ('Mean MC', 'FontSize',14)

%% distribution for various MC

tiledlayout(4,1);
figure('Name','MC Distribution','NumberTitle','off'); % will not print 'Figure 1, 2, etc. just name'
ax1 = nexttile;
histfit(ax1,fn(1:20000));
xlabel ('MC for Standard Leg Design')
ylabel ('Frequency');
title(ax1,'Normal Distribution skewness = ',[skewness(fn)]);

ax2 = nexttile;
histfit(ax2,fn5(1:20000));
xlabel ('MC for Blade 5 mm Leg Design')
ylabel ('Frequency');
title(ax2,'Normal Distribution skewness = ', [skewness(fn5)]);

ax3 = nexttile;
histfit(ax3,fn3(1:20000));
xlabel ('MC for Blade 3 mm Leg Design')
ylabel ('Frequency');
%legend(ax3, skewness(fn3))
title(ax3,'Normal Distribution skewness = ', [skewness(fn3)]);
ax4 = nexttile;
histfit(ax4,fn5(1:20000));
xlabel ('MC for Blade 2 mm Leg Design')
ylabel ('Frequency');

title(ax4,'Normal Distribution skewness = ', [skewness(fn2)]);


%%  create vectors for anova
grp = ['Standard Leg','Blade 5 mm','Blade 3 mm', 'Blade 2 mm'];
MCD_array = [fn(1:20000), fn5(1:20000), fn3(1:20000), fn2(1:20000)];
[p,tbl,stats] = anova1(MCD_array);

%%
multcompare (stats);



