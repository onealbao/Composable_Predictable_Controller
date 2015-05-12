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

function next_x = rc_sysAct1(v)

global rc_TIME_UNIT
global rc_CTIME
global u_max1
global alpha
global e1
global ein1
global total_e
global total_y
global round_num1
global buffer1
global q_max
global  q_overflow
global total_Speed_Switch
global TOTALCOST
persistent cur_state;

if rc_CTIME == 0,
    next_x    = [0 0 0 0 300.0000 0.3479 0];
    
else
    x = cur_state;
    q = x(1); % last queue level
    y = x(2); % last throuput -- no use
    
    %
    %ein1(rc_CTIME) = v(1);
    %
    
    % read incoming packages
    read_ar = v(1);
    
    round_num1 = round_num1 + 1;
    if rc_CTIME > 1
        buffer1(round_num1) = v(1);
      
    end
    
    
    % new velocity after receive control input
    adjust_u = v(2) * u_max1;
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
    next_x = [next_q next_y adjust_u next_ec read_ar v(2) e1(rc_CTIME) ];
    
    total_y =  total_y + next_y;
    total_e = total_e + next_ec;
    total_Speed_Switch = total_Speed_Switch + abs(adjust_u-x(3));
    
        x1 = next_ec*next_ec;
    x2 = next_y*next_y;
    x3 = abs(x(3)-adjust_u);

  costMatrix = -(x1)/(1000*1000*1000*1000*alpha*alpha) + (x2)/(1000*1000)-x3/774*7/1000;

 
   TOTALCOST = TOTALCOST + costMatrix;
end

cur_state = next_x;
 if rc_CTIME == 8999,
   for x = 1: 8998
        ee1(x) = e1 (x+1);
    end   
    mean_of_estimation1 = mean(ee1)
   
    std_of_estimation1 = std(ee1)
 end