%--------------------------------------------------------------------------
% Filename: pm_einPredict.m
% Author: Sherif Abdelwahed 
% Last modified: 4/26/2005
% Copyright (c) 2005-2006 ISIS, Vanderbilt University
%--------------------------------------------------------------------------
% Description:
% This is the prediction module. It has access to all the previous history
% of the input and it produces a prediction vection for the specified
% lookahead horizon
%--------------------------------------------------------------------------
% Output:
%   next_x =  next state vector 
%--------------------------------------------------------------------------

function est_ein = rc_einPredict2()

global rc_LOOKAHEAD_STEPS   % prediction horizon
global ein2                 % environment input
global rc_CTIME             % current time

%----- simple moving average predictor ----
w_av = [0.05 0.15 0.8];

pred_span = size(w_av, 2);

est_ein = zeros(rc_LOOKAHEAD_STEPS,1);
prev_e  = [200 200 200]';

if (rc_CTIME > 0)
    if (rc_CTIME == 1)
       
       prev_e = [ein2(rc_CTIME) 200 200]';
        
    elseif  (rc_CTIME == 2)
        prev_e = [ein2(rc_CTIME - 1) ein2(rc_CTIME) 200]';
    elseif  (rc_CTIME == 3)
        prev_e = [ein2(rc_CTIME - 2) ein2(rc_CTIME - 1) ein2(rc_CTIME)]';
        %prev_e = ein2(rc_CTIME-pred_span+1:rc_CTIME);
    else
        prev_e = ein2(rc_CTIME-3:rc_CTIME-1);
    end
end

for i = 1:rc_LOOKAHEAD_STEPS,
    est_ein(i) = w_av*prev_e;
    prev_e = [prev_e(i+1:size(w_av,2))' est_ein(1:i)']';
end
