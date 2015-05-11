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

function est_ein = rc_ARIMA()

global rc_LOOKAHEAD_STEPS   % prediction horizon
% global ein                  % environment input
% global randomWorkload
% global rc_CTIME             % current time
global round_num            % total round we have 
global buffer

%----- simple moving average predictor ----

w_av_arima = [0.1 0.9];

est_ein = zeros(rc_LOOKAHEAD_STEPS,1);
for init = 1:100
    pre_100(init) = 1000;
end
if (round_num < 100 && round_num >1)
    prev_e = buffer(1:round_num);
    % use to calculate average of first several packages
    pre_first_part = prev_e(1:round_num-1);
    arima = [mean(pre_first_part),prev_e(round_num)]';
    
    for i = 1:rc_LOOKAHEAD_STEPS,
          est_ein(i) = w_av_arima * arima;
          if rc_LOOKAHEAD_STEPS > 2
              % starts from step = 3
              pre_first_part = [prev_e(i:round_num)' est_ein(1:i-1)']';
              arima = [mean(pre_first_part), est_ein(i)]';
          elseif rc_LOOKAHEAD_STEPS == 2
              
              pre_first_part = prev_e(2:round_num)';
              arima = [mean(pre_first_part), est_ein(1)]';
          end
          
     end
end    


if (round_num > 100) 
    
      %prev_e = ein(round_num-pred_span+1:round_num);
    prev_e = buffer(round_num-100:round_num);
   
    
    pre_100 = prev_e(1:100)';   
    
   arima = [mean(pre_100),prev_e(101)]';
     for i = 1:rc_LOOKAHEAD_STEPS,
          est_ein(i) = w_av_arima * arima;
          if rc_LOOKAHEAD_STEPS > 2
              % starts from step = 3
              pre_100 = [prev_e(i:101)' est_ein(1:i-1)']';
              arima = [mean(pre_100), est_ein(i)]';
          elseif rc_LOOKAHEAD_STEPS == 2
              
              pre_100 = prev_e(2:101)';
              arima = [mean(pre_100), est_ein(1)]';
          end
          
     end
   
    

end


% 
% for i = 1:rc_LOOKAHEAD_STEPS,
%     est_ein(i) = w_av_arima*prev_e;
%     prev_e = [prev_e(i+1:size(w_av,2))' est_ein(1:i)']';
% end


%   arima = [mean(pre_100),prev_e(101)]';
%     for i = 1:rc_LOOKAHEAD_STEPS,
%          est_ein(i) = w_av_arima * arima;
%          if rc_LOOKAHEAD_STEPS > 2
%              % starts from step = 3
%              pre_100 = [prev_e(i:101)' est_ein(1:i-1)']';
%              arima = [mean(pre_100), est_ein(i)]';
%          elseif rc_LOOKAHEAD_STEPS == 2
%              1
%              pre_100 = prev_e(2:101)';
%              arima = [mean(pre_100), est_ein(1)]';
%          end
%          
%     end

