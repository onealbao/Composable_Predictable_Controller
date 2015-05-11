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

function next_x = rc_sysAct(v)


global rc_TIME_UNIT
global rc_CTIME
global u_max
global alpha
global e
global total_e
global q_max
global buffer         
global round_num
global TOTALCOST
global a1
global a2
global a3
global ein
global finalspeed
global randomWorkload

persistent cur_state;

if rc_CTIME == 0,
    next_x    = [0 0 0 0 300.0000 0.3479 0];
    
else
    x = cur_state;
    q = x(1); % last queue level
    y = x(2); % last throuput -- no use
    
    % read incoming packages
    read_ar = v(1);
    % save the incoming package to the buffer
    round_num = round_num + 1;
    if rc_CTIME > 1
        buffer(round_num) = v(1);
       
    end
    
    % new velocity after receive control input
    adjust_u = v(2) * u_max;
    % next throughput
    next_y = min(q,adjust_u * rc_TIME_UNIT);
    % next queue level
    next_q = max(q + (read_ar - next_y)*rc_TIME_UNIT, 0);
      if next_q > q_max
          next_q = q_max;
      end    
    % next energy consumption
    next_ec = alpha * adjust_u * adjust_u;
    % output signal
    next_x = [next_q next_y adjust_u next_ec read_ar v(2) e(rc_CTIME) ];
    
    total_e = total_e + next_ec;
    finalspeed(rc_CTIME) = adjust_u;
end


cur_state = next_x;

if rc_CTIME == 8999,
    

    size_of_estimation0 = size(e)
    %mean_of_estimation0 = mean(e)

    total_cost = TOTALCOST
    
    save a11 a1
    save a22 a2
    save a33 a3


    save speed ssppeedd
    
end