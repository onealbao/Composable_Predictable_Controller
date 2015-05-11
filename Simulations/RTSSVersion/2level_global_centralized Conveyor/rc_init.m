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
global rc_GLOBAL_TIME

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

global u_max           % Max velocity
global u_max1
global u_max2
global u_max3
global u_max4
global u_max5
global q_max           % Max queue size
global alpha           % use to calculate the energy consumption
global total          % Total packages are being transmitted
global total_e        % Total energy consumption
global total_y
global total_Speed_Switch
global ct

%%%%%%%%%%For global controller part
global q_level
global q1_level
global q2_level
global q3_level
global q4_level
global q5_level
global y_level
global y1_level
global y2_level
global y3_level
global y4_level
global y5_level
global u_level
global u1_level
global u2_level
global u3_level
global u4_level
global u5_level
global ar_level
global ar1_level
global ar2_level
global ar3_level
global ar4_level
global ar5_level

global rc_INPUT_SET_G
global rc_LOOKAHEAD_STEPS_G
global rc_INPUT_SEQS_G
global rc_IN_TRACES_NO_G

global rc_INPUT_SET_BIG
global rc_LOOKAHEAD_STEPS_BIG
global rc_INPUT_SEQS_BIG
global rc_IN_TRACES_NO_BIG

global rc_LOOKAHEAD_STEP_GLOBAL_CHANGE


%--------- Initialization of global constants ---------
rc_LOOKAHEAD_STEP_GLOBAL_CHANGE = 3;
rc_STATE_SIZE = 3;
rc_TIME_UNIT = 1;
rc_INPUT_SET = [0.2564  0.3479  0.4349  0.5219  0.650 0.7829  1.0000];
rc_LOOKAHEAD_STEPS = 2; 
rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
rc_CTIME = 0;
rc_GLOBAL_TIME = 0;

load ein_sm1;

ct = cputime;


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

q_max = 1500;


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
total_Speed_Switch=0;

%%%%%%%%%%For global controller part
q_level = zeros(size(60));
q1_level = zeros(size(60));
q2_level = zeros(size(60)); 
q3_level = zeros(size(60));
q4_level = zeros(size(60));
q5_level = zeros(size(60));
y_level = zeros(size(60));
y1_level = zeros(size(60));
y2_level = zeros(size(60));
y3_level = zeros(size(60));
y4_level = zeros(size(60));
y5_level = zeros(size(60));
u_level = zeros(size(60));
u1_level = zeros(size(60));
u2_level = zeros(size(60));
u3_level = zeros(size(60));
u4_level = zeros(size(60));
u5_level = zeros(size(60));
ar_level = zeros(size(60));
ar1_level = zeros(size(60));
ar2_level = zeros(size(60));
ar3_level = zeros(size(60));
ar4_level = zeros(size(60));
ar5_level = zeros(size(60));

rc_INPUT_SET_G = [0.2564  0.3479  0.4349  0.5219  0.650 0.7829  1.0000];
rc_LOOKAHEAD_STEPS_G = 1; 
rc_INPUT_SEQS_G = cartprod(rc_INPUT_SET_G, rc_LOOKAHEAD_STEPS_G);
rc_IN_TRACES_NO_G = size(rc_INPUT_SEQS_G, 1);

rc_INPUT_SET_BIG = [0.2564  0.3479  0.4349  0.5219  0.650 0.7829  1.0000];
rc_LOOKAHEAD_STEPS_BIG = 1; 
rc_INPUT_SEQS_BIG = cartprod(rc_INPUT_SET_BIG, rc_LOOKAHEAD_STEPS_BIG);
rc_IN_TRACES_NO_BIG = size(rc_INPUT_SEQS_BIG, 1);

%-------- utility function parameters -------
Q1 = [1 0 0; 0 1 0; 0 0 1];
