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

%----- system specific constants
%%%%%global rc_PROC_TIME    %% processing time
global ein             % environment input
global ein1            % environment input of belt1
global ein2            % environment input of belt2
global ein3            % environment input of belt3
global ein4            % environment input of belt4
global ein5            % environment input of belt5

global Q1              % state weight matrix

global e               % difference for the real arrival rate and anticipation rate
global e1
global e2
global e3
global e4
global e5
global TOTALCOST
global total_Speed_Switch

global u_max           % Max velocity
global u_max1
global u_max2
global u_max3
global u_max4
global u_max5
global q_max           % Max queue size
global q_max2

global buffer             % environment input
global buffer1            % environment input of belt1
global buffer2            % environment input of belt2
global buffer3            % environment input of belt3
global buffer4            % environment input of belt4
global buffer5            % environment input of belt5
global round_num % the number of total time unit
global round_num1 % the number of total time unit
global round_num2 % the number of total time unit
global round_num3 % the number of total time unit
global round_num4 % the number of total time unit
global round_num5 % the number of total time unit



global alpha           % use to calculate the energy consumption
global total          % Total packages are being transmitted
global total_e        % Total energy consumption
global total_y               % Total throughput 
global ct
global q_overflow

%--------- Initialization of global constants ---------
ct      = cputime;   % CPU time
q_overflow = 0;
rc_STATE_SIZE = 3;
rc_TIME_UNIT = 1;
rc_INPUT_SET = [0.2564  0.3479  0.4349  0.5219  0.650 0.7829  1.0000];
rc_LOOKAHEAD_STEPS = 3; 
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

q_max = 2000;
q_max2 = 2500;

buffer  = zeros(size(ein));
buffer1 = zeros(size(ein));
buffer2 = zeros(size(ein));
buffer3 = zeros(size(ein));
buffer4 = zeros(size(ein));
buffer5 = zeros(size(ein));
round_num  =0;% the number of total time unit
round_num1 =0;% the number of total time unit
round_num2 =0;% the number of total time unit
round_num3 =0;% the number of total time unit
round_num4 =0;% the number of total time unit
round_num5 =0;% the number of total time unit


u_max  = 1000.0000;
u_max1 = 1000.0000;
u_max2 = 1000.0000;
u_max3 = 1000.0000;
u_max4 = 1000.0000;
u_max5 = 2000.0000;

alpha = 0.5;
total = 0;
total_e = 0;
total_y = 0;
TOTALCOST = 0;
total_Speed_Switch = 0;

%-------- utility function parameters -------
Q1 = [1 0 0; 0 1 0; 0 0 1];
