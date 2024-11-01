%% Initialization
% This is to compute MC on the real robot with a 3 mm blade leg, both actuated
% Key difference is that the bin size is 100
clear;

% Load data
load("/MATLAB Drive/MC_flipper/crawling_data.mat");
% Name our dataset
myStruct.name = 'Flipper_data_sand';

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
position_X_min = min(myStruct.motor2_position_X);
position_X_max = max(myStruct.motor2_position_X);

% Get the max/min values of load data
load_min = min(myStruct.motor2_load);
load_max = max(myStruct.motor2_load);

real_string = [real_string 'Domains\n' ...
    sprintf('  Position:        %f, %f\n', position_X_min, position_X_max) ...
    sprintf('  Load:        %f, %f\n', load_min, load_max)];

%% Discretise Test
bins = 31;  % Number of bins for discretization
fprintf('Bins = %d\n', bins)

% Call the discretiseMatrix function for position and load
myStruct.discrete_position = discretiseMatrix(myStruct.motor2_position_X, ...
    'min', position_X_min, ...
    'max', position_X_max, ...
    'bins', bins);

myStruct.discrete_load = discretiseMatrix(myStruct.motor2_load, ...
    'min', load_min, ...
    'max', load_max, ...
    'bins', bins);


%% Visualize bins:
fprintf('Discrete Position:\n');
disp(myStruct.discrete_position);

fprintf('Discrete Load:\n');
disp(myStruct.discrete_load);