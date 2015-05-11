%--------------------------------------------------------------------------
% Filename: rc_sysAct.m
% Author: Shunxing Bao 
% Last modified: 10/06/2014
% Copyright (c) 2014 ISIS, Vanderbilt University
%--------------------------------------------------------------------------
% Description:
% The actual belt model. 
%--------------------------------------------------------------------------
% Input:
%   v(1) = estimated environment input (to compute estimation error) from
%   file ein
%   v(2) = control input (from controller)
% Output:
%   next_m = next measurments (including input, environment input and 
%            estimation error for ploting)
%    
%    Output state vector
%    1. next queue level
%    2. next throuput 
%    3. adjust velocity
%    4. next energy consumption
%    5. current arriving rate
%    6. current control input
%    7. current estimation error
%--------------------------------------------------------------------------

function next_x = rc_sysAct5(v)

global rc_TIME_UNIT
global rc_CTIME
global u_max5
global q_max
global alpha
global e5
global ein5
global total_e
global TOTALCOST
global ct
global total_y
global total_Speed_Switch
persistent cur_state;

if rc_CTIME == 0,
    next_x    = [0 0 0 0 300.0000 0.3479 0];
    
else
    x = cur_state;
    q = x(1); % last queue level
    y = x(2); % last throuput -- no use
    
    ein5(rc_CTIME) = v(1);
   
    % read incoming packages
    read_ar = v(1);
    % new velocity after receive control input
    adjust_u = v(2) * u_max5;
    % next throughput
    next_y = min(q,adjust_u * rc_TIME_UNIT);
    % next queue level
    next_q = max(q + (read_ar - next_y)*rc_TIME_UNIT, 0);
  
    % next energy consumption
    next_ec = alpha * adjust_u * adjust_u;
    % output signal
    next_x = [next_q next_y adjust_u next_ec read_ar v(2) e5(rc_CTIME) ];
    
    total_e = total_e + next_ec;
    total_y = total_y + next_y;
    total_Speed_Switch = total_Speed_Switch + abs(adjust_u-x(3));
end


cur_state = next_x;
 if rc_CTIME == 8999,

    total_energy_consumption = total_e
    time = cputime - ct
    max_speed = u_max5;
     total_throughput = total_y
    total_speed_switch_cost =  total_Speed_Switch
    total_Cost = TOTALCOST(1)
   
 end