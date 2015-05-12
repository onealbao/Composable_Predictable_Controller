% Template for limited lookahead control
% Filename: rc_LLC.m
% Author: Shunxing Bao
% Last modified: 10/06/2014
% Copyright (C) 2014 ISIS, Vanderbilt University
%--------------------------------------------------------------------------
% Description:
% limited lookahead controller. Maximize a the utility of a given system  
% based on limited lookahead search. System dynamics is defined in
% "rc_sysModel". State constraints is defined in "rc_isValidState". System
% utility is defined in "rc_sysUtility"
%--------------------------------------------------------------------------
% Input:
%   cx = current state vector 
%--------------------------------------------------------------------------
% Output:
%   v = control input 
%--------------------------------------------------------------------------

function v = rc_LLC3(cm)

global rc_STATE_SIZE            % the size of the state space
global rc_LOOKAHEAD_STEPS       % number of lookahead steps
global rc_INPUT_SEQS            % all possible input sequences (traces)
global rc_IN_TRACES_NO          % number of all possible traces 
global rc_CTIME
global e3
global TOTALCOST

persistent last_ar;
if rc_CTIME > 2,
    temp = cm(5);
    e3(rc_CTIME) = [last_ar(1) - temp];
end

fx = zeros(rc_LOOKAHEAD_STEPS, rc_STATE_SIZE); % 1*x array

best_util  = -Inf; % initialize the best_util to be minus infinity
v = rc_INPUT_SEQS(1,1);

est_ein = rc_einPredict3();
last_ar = est_ein(1);

cx = [cm(1) cm(2) cm(3)];  % current state

for i = 1:rc_IN_TRACES_NO,
    fx(1,:) = cx;
    valid_set = 1;
    
    for j = 1:rc_LOOKAHEAD_STEPS,
        if rc_isValidInput(fx(j,:), rc_INPUT_SEQS(i,j)) == 1, % no use this line since the return value is always 1
            fx(j+1,:) = rc_sysModel3(fx(j,:), rc_INPUT_SEQS(i,j), est_ein(j));
            
            if rc_isValidState(fx(j+1,:)), % no use this line since the return value is always 1
              
                continue;
            end
        end
        valid_set = 0;
        break;
    end
   
    if valid_set == 1,
       current_u = cm(3);
        cur_util = rc_sysCost(fx,current_u);
         
        if cur_util(1) > best_util
            best_util = cur_util(1);
           
            v = rc_INPUT_SEQS(i,1);
        end 
       
    end
end

% TOTALCOST = TOTALCOST + best_util;
