%--------------------------------------------------------------------------
% Filename: pm_sysModel.m
% Author: Shunxing Bao 
% Last modified: 10/06/2014
% Copyright (c) 2014 ISIS, Vanderbilt University
%--------------------------------------------------------------------------
% Description:
% The mathematical system model. It is a discrete time hybrid switching 
% system model relating the next state to current state and input. The 
% model can be multi-mode depending on the state and input values. 
%--------------------------------------------------------------------------
% Input:
%   x = the current state vector
%   u = current control input
%   w = predict control input
% Output:
%   next_x =  next state vector 
%--------------------------------------------------------------------------

function next_x = rc_sysModel2(x,u,w)

global rc_TIME_UNIT         % the sampling time of the system
global u_max2
global alpha

%----- state variables ----

cur_q = x(1); % queue level
cur_y = x(2); % throughput level 

%----- state equations ---

% next belt velocity
adjust_u = u * u_max2;
% next throughput 
next_y = min(cur_q, adjust_u * rc_TIME_UNIT);
% next queue level
next_q = max(cur_q + ( w - adjust_u )* rc_TIME_UNIT, 0); 
% next energy consumption
next_ec = alpha * u * u;
% Output
next_x = [next_q next_y next_ec];
