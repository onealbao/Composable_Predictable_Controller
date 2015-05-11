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
global ein             % environment input
global Q1              % state weight matrix

global e               % difference for the real arrival rate and anticipation rate

global TOTALCOST

global u_max           % Max velocity

global q_max           % Max queue size
global alpha           % use to calculate the energy consumption
global total          % Total packages are being transmitted
global total_e        % Total energy consumption

global buffer         % buffer for belt, save history data
global round_num % the number of total time unit

%%test
global a1
global a2
global a3
global index
global finalspeed

a1 = zeros(size(60000));
a2 = zeros(size(60000));
a3 = zeros(size(60000));
index = 1;
%--------- Initialization of global constants ---------

rc_STATE_SIZE = 3;
rc_TIME_UNIT = 1;
rc_INPUT_SET = [0.2564  0.3479  0.4349  0.5219  0.650 0.7829  1.0000];
rc_LOOKAHEAD_STEPS = 2; 
rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
rc_CTIME = 0;

load ein_sm1;
load randomWorkload;
load xxx;
load yyy;

e      = zeros(size(ein));

buffer = zeros(size(ein));
finalspeed = zeros(size(ein));
round_num = 0;

q_max = 1000;

u_max  = 1000.0000;


alpha = 0.5;
total = 0;
total_e = 0;
TOTALCOST = 0;


%-------- utility function parameters -------
Q1 = [1 0 0; 0 1 0; 0 0 1];
