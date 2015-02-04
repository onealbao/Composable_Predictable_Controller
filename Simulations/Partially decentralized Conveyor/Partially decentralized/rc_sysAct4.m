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

function next_x = rc_sysAct4(v)

global rc_TIME_UNIT
global rc_CTIME
global u_max4
global alpha
global e4
global ein4
global energyCost

persistent cur_state;

if rc_CTIME == 0,
    next_x    = [0 0 0 0 300.0000 0.3479 0 0];
    
else
    x = cur_state;
    q = x(1); % last queue level
    y = x(2); % last throuput -- no use
    
    ein4(rc_CTIME) = v(1);
    
    if rc_CTIME <10
        s4 = ein4(rc_CTIME)
    end
    
    % read incoming packages
    read_ar = v(1);
    % new velocity after receive control input
    adjust_u = v(2) * u_max4;
    % previous belt's speed
    pre_belt_u = v(3);
    % next throughput
    next_y = min(q,adjust_u * rc_TIME_UNIT);
    % next queue level
    next_q = max(q + (read_ar - next_y)*rc_TIME_UNIT, 0);
    % next energy consumption
    next_ec = alpha * adjust_u * adjust_u;
    % output signal
    next_x = [next_q next_y adjust_u next_ec read_ar v(2) e4(rc_CTIME) pre_belt_u ];
   
     energyCost = energyCost + next_ec;
end

cur_state = next_x;
 if rc_CTIME == 8999,
    mean_of_estimation = mean(e4)
    std_of_estimation = std(e4)
 end



