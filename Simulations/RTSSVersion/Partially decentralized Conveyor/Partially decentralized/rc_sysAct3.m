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
%    8. previous belt speed
%--------------------------------------------------------------------------

function next_x = rc_sysAct3(v)

global rc_TIME_UNIT
global rc_CTIME
global u_max3
global alpha
global e3
global ein3
global energyCost
global  total_y
global total_Speed_Switch
global q_max
global q_overflow
global TOTALCOST

persistent cur_state;

if rc_CTIME == 0,
    next_x    = [0 0 0 0 300.0000 0.3479 0 0];
    
else
    x = cur_state;
    q = x(1); % last queue level
    y = x(2); % last throuput -- no use
    
    ein3(rc_CTIME) = v(1);
    
   
    
    % read incoming packages
    read_ar = v(1);
    % new velocity after receive control input
    adjust_u = v(2) * u_max3;
    % previous belt's speed
    pre_belt_u = v(3);
    % next throughput
    next_y = min(q,adjust_u * rc_TIME_UNIT);
    % next queue level
    next_q = max(q + (read_ar - next_y)*rc_TIME_UNIT, 0);

    if next_q > q_max
        next_q = q_max;
         q_overflow = q_overflow+1;
    end 
    % next energy consumption
    next_ec = alpha * adjust_u * adjust_u;
    % output signal
    next_x = [next_q next_y adjust_u next_ec read_ar v(2) e3(rc_CTIME) pre_belt_u];
    
     total_y = total_y + next_y;
     energyCost = energyCost + next_ec;
         total_Speed_Switch = total_Speed_Switch + abs(adjust_u-x(3));
         
     

    x1 = next_ec*next_ec;
    x2 = next_y*next_y;
    x3 = abs(x(3)-adjust_u);


  costMatrix = -(x1)/(1000*1000*1000*1000*alpha*alpha) + (x2)/(1000*1000)-x3/774*7/1000;
  TOTALCOST = TOTALCOST + costMatrix;
end

cur_state = next_x;

if rc_CTIME == 8999,
%     mean_of_estimation = mean(e3)
%     std_of_estimation = std(e3)
end




