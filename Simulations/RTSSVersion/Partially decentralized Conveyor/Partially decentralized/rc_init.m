% Initialization template for the limited lookahead control module
%------------------------------------------------------------------------
% Filename: rc_init.m 
% Author: Shunxing Bao
% Last modified: 10/5/2014
% Copyright 2014 ISIS, Vanderbilt Univerusty
%------------------------------------------------------------------------

% system initialization function 
function rc_init
clear all; clc

%----------- Declaration of global constants ----------
global rc_STATE_SIZE % state vector size       
global rc_TIME_UNIT % 
global rc_INPUT_SET  %???????????       
global rc_LOOKAHEAD_STEPS
global rc_INPUT_SEQS %???????????
global rc_IN_TRACES_NO 
global rc_CTIME
global ct

%----- system specific constants
%%%%%global rc_PROC_TIME    %% processing time
global ein             % environment input
global ein1            % environment input of belt1
global ein2            % environment input of belt2
global ein3            % environment input of belt3
global ein4            % environment input of belt4
global ein5            % environment input of belt5
global buffer             % environment input
global buffer1            % environment input of belt1
global round_num % the number of total time unit
global round_num1 % the number of total time unit

global Q1              % state weight matrix

global e               % difference for the real arrival rate and anticipation rate
global e1
global e2
global e3
global e4
global e5

global TOTALCOST

global energyCost

global u_max           % Max velocity
global u_max1
global u_max2
global u_max3
global u_max4
global u_max5
global q_max           % Max queue size
global alpha           % use to calculate the energy consumption
global total          % Total packages are being transmitted
global total_y
global total_Speed_Switch
global q_max2
global q_overflow

%--------- Initialization of global constants ---------
ct = cputime;
q_overflow = 0;
rc_STATE_SIZE = 3;
rc_TIME_UNIT = 1;
rc_INPUT_SET = [0.2564  0.3479  0.4349  0.5219  0.650 0.7829  1.0000];
rc_LOOKAHEAD_STEPS = 1; 
rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
rc_CTIME = 0;

load ein_sm1;

ein1 = zeros(size(ein));
ein2 = zeros(size(ein));
ein3 = zeros(size(ein));
ein4 = zeros(size(ein));
ein5 = zeros(size(ein));

e      = zeros(size(ein));
e1      = zeros(size(ein));
e2     = zeros(size(ein));
e3     = zeros(size(ein));
e4     = zeros(size(ein));
e5      = zeros(size(ein));

TOTALCOST = 0;
energyCost = 0;

q_max = 1500;
q_max2 = 2500;
u_max  = 1000.0000;
u_max1 = 1000.0000;
u_max2 = 1000.0000;
u_max3 = 1000.0000;
u_max4 = 1000.0000;
u_max5 = 2000.0000;

alpha = 0.5;
total = 0;
total_y = 0;
total_Speed_Switch=0;

buffer  = zeros(size(ein));
buffer1 = zeros(size(ein));

round_num  =0;% the number of total time unit
round_num1 =0;% the number of total time unit


