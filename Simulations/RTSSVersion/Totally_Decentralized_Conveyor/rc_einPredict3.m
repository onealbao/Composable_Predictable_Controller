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

function est_ein = rc_einPredict3()

global rc_LOOKAHEAD_STEPS   % prediction horizon
global ein3                 % environment input
global rc_CTIME             % current time
global buffer3
global round_num3


%----- simple moving average predictor ----
w_av = [0.05 0.15 0.8];

pred_span = size(w_av, 2);

est_ein = zeros(rc_LOOKAHEAD_STEPS,1);
prev_e  = [200 200 200]';

if (round_num3 > 0)
    if (round_num3 == 1)
       
       prev_e = [buffer3(round_num3) 200 200]';
        
    elseif  (round_num3 == 2)
        prev_e = [buffer3(round_num3 - 1) buffer3(round_num3) 200]';
    elseif  (round_num3 == 3)
        prev_e = [buffer3(round_num3 - 2) buffer3(round_num3 - 1) buffer3(round_num3)]';
        %prev_e = ein3(rc_CTIME-pred_span+1:rc_CTIME);
    else
        prev_e = buffer3(round_num3-2:round_num3);
         
    end
end

for i = 1:rc_LOOKAHEAD_STEPS,
    est_ein(i) = w_av*prev_e;
    prev_e = [prev_e(i+1:size(w_av,2))' est_ein(1:i)']';
end
