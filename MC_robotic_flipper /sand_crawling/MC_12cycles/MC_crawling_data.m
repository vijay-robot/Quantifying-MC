%% Initialization
% This is to compute MC on the real robot with a 3 mm blade leg, both actuated 
% Key difference is that the bin size is 100

clear;

% Load data
load("/MATLAB Drive/12cycle_vijay/myStruct12.mat");
% Name our dataset
myStruct12.name = 'Flipper_data_sand_12cycles';

%% 1. Step: Extract min/max values for each column that will be used
% Define initial min/max values
position_X_min  = 0; 
position_X_max = 289.13;
load_min = 0; 
load_max = 256;

% Initialize string for output
real_string = '';

% Assuming myStruct is populated with data from crawling_data.mat
% Uncomment the next lines to load data into myStruct if needed
% myStruct.motor2_position_X  = position_X_crawl(:,31); % Joint angle of hip
% myStruct.motor2_load        = load_crawl(:,31); % Load data

% Get the max/min values of position data
position_X_min = min(myStruct12.motor2_position_X_12cycles);
position_X_max = max(myStruct12.motor2_position_X_12cycles);
% Get the max/min values of load data
load_min = min(myStruct12.motor2_load_12cycles);
load_max = max(myStruct12.motor2_load_12cycles);

real_string = [real_string 'Domains\n' ...
    sprintf('  Position:        %f, %f\n', position_X_min, position_X_max) ...
    sprintf('  Load:        %f, %f\n', load_min, load_max)];

%% Discretise Test
bins = 370;  % Number of bins for discretization
fprintf('Bins = %d\n', bins)

% Call the discretiseMatrix function for position and load
myStruct12.discrete_position = discretiseMatrix(myStruct12.motor2_position_X_12cycles, ...
    'min', position_X_min, ...
    'max', position_X_max, ...
    'bins', bins);

myStruct12.discrete_load = discretiseMatrix(myStruct12.motor2_load_12cycles, ...
    'min', load_min, ...
    'max', load_max, ...
    'bins', bins);


%% Visualize bins:
fprintf('Discrete Position:\n');
disp(myStruct12.discrete_position);

fprintf('Discrete Load:\n');
disp(myStruct12.discrete_load);

%% run MC quantification
% 

fprintf('Working on file %s\n', myStruct12.name)

myStruct12.w2= myStruct12.discrete_position(2:end,:);
myStruct12.w1 = myStruct12.discrete_position(1:end-1,:);

myStruct12.a1 = myStruct12.discrete_load(1:end-1,:);
%%
%Total MC
myStruct12.mcw  = MC_W1(myStruct12.w2, myStruct12.w1, myStruct12.a1);
fprintf('MC_W %f\n', myStruct12.mcw);
%%
%Dynamic MC
myStruct12.mcd  = MC_W1_dynamic(myStruct12.w2, myStruct12.w1, myStruct12.a1);
mean(myStruct12.mcd)
%%
%plotting

plot(myStruct12.discrete_position)
title ('Position and Load')
hold on;
plot(myStruct12.discrete_load);
hold off;
plot(myStruct12.mcd)
hold on;
plot (smooth(myStruct12.mcd))
legend('actual MC', 'smooth MC')
title ('MC_sand_12cycles');