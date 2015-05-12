function v = rc_global(cm)

global rc_GLOBAL_TIME
global rc_CTIME
global q_level
global q1_level
global q2_level
global q3_level
global q4_level
global q5_level
global y_level
global y1_level
global y2_level
global y3_level
global y4_level
global y5_level
global u_level
global u1_level
global u2_level
global u3_level
global u4_level
global u5_level
global ar_level
global ar1_level
global ar2_level
global ar3_level
global ar4_level
global ar5_level
global TOTALCOST
global rc_STATE_SIZE            % the size of the state space
global rc_LOOKAHEAD_STEPS       % number of lookahead steps
global rc_INPUT_SEQS            % all possible input sequences (traces)
global rc_IN_TRACES_NO          % number of all possible traces 


if  rc_GLOBAL_TIME <= 60 && rc_GLOBAL_TIME > 0 && rc_CTIME > 10

    q_level(rc_GLOBAL_TIME)  = cm(7) ;
    q1_level(rc_GLOBAL_TIME) = cm(8) ;
    q2_level(rc_GLOBAL_TIME) = cm(9) ;
    q3_level(rc_GLOBAL_TIME) = cm(10) ;
    q4_level(rc_GLOBAL_TIME) = cm(11) ;
    q5_level(rc_GLOBAL_TIME) = cm(12) ;
    
    y_level(rc_GLOBAL_TIME)  = cm(1) ;
    y1_level(rc_GLOBAL_TIME) = cm(2) ;
    y2_level(rc_GLOBAL_TIME) = cm(3) ;
    y3_level(rc_GLOBAL_TIME) = cm(4) ;
    y4_level(rc_GLOBAL_TIME) = cm(5) ;
    y5_level(rc_GLOBAL_TIME) = cm(6) ;
    
    u_level(rc_GLOBAL_TIME)  = cm(13) ;
    u1_level(rc_GLOBAL_TIME) = cm(14) ;
    u2_level(rc_GLOBAL_TIME) = cm(15) ;
    u3_level(rc_GLOBAL_TIME) = cm(16) ;
    u4_level(rc_GLOBAL_TIME) = cm(17) ;
    u5_level(rc_GLOBAL_TIME) = cm(18) ;
    
    ar_level(rc_GLOBAL_TIME)  = cm(19) ;
    ar1_level(rc_GLOBAL_TIME) = cm(20) ;
    ar2_level(rc_GLOBAL_TIME) = cm(21) ;
    ar3_level(rc_GLOBAL_TIME) = cm(22) ;
    ar4_level(rc_GLOBAL_TIME) = cm(23) ;
    ar5_level(rc_GLOBAL_TIME) = cm(24) ;
end

%%
% SEGMENT 0

fx = zeros(rc_LOOKAHEAD_STEPS, rc_STATE_SIZE); % 1*x array

best_util  = -Inf; % initialize the best_util to be minus infinity
v(1,1) = rc_INPUT_SEQS(1,1);

est_ein = rc_einPredict();

cx = [cm(7) cm(1) cm(13)];  % current state

for i = 1:rc_IN_TRACES_NO,
    fx(1,:) = cx;
    valid_set = 1;
    
    for j = 1:rc_LOOKAHEAD_STEPS,
        if rc_isValidInput(fx(j,:), rc_INPUT_SEQS(i,j)) == 1, % no use this line since the return value is always 1
            fx(j+1,:) = rc_sysModel(fx(j,:), rc_INPUT_SEQS(i,j), est_ein(j));
            
            if rc_isValidState(fx(j+1,:)), % no use this line since the return value is always 1
              
                continue;
            end
        end
        valid_set = 0;
        break;
    end
   if valid_set == 1,
       current_u = cm(13);
        cur_util = rc_sysCost(fx,current_u);
         
        if cur_util(1) > best_util
            best_util = cur_util(1);
           
            v(1,1) = rc_INPUT_SEQS(i,1);
        end 
       
    end
end
 %TOTALCOST = TOTALCOST + best_util;

 %%
 %SEGMENT 1
 fx = zeros(rc_LOOKAHEAD_STEPS, rc_STATE_SIZE); % 1*x array

best_util  = -Inf; % initialize the best_util to be minus infinity
v(1,2) = rc_INPUT_SEQS(1,1);

est_ein = rc_einPredict1();
cx = [cm(8) cm(2) cm(14)];  % current state

for i = 1:rc_IN_TRACES_NO,
    fx(1,:) = cx;
    valid_set = 1;
    
    
    for j = 1:rc_LOOKAHEAD_STEPS,
        if rc_isValidInput(fx(j,:), rc_INPUT_SEQS(i,j)) == 1, % no use this line since the return value is always 1
            fx(j+1,:) = rc_sysModel1(fx(j,:), rc_INPUT_SEQS(i,j), est_ein(j));
            
            if rc_isValidState(fx(j+1,:)), % no use this line since the return value is always 1
              
                continue;
            end
        end
        valid_set = 0;
        break;
    end
   
    
    if valid_set == 1,
       current_u = cm(14);
        cur_util = rc_sysCost(fx,current_u);
         
        if cur_util(1) > best_util
            best_util = cur_util(1);
           
            v(1,2) = rc_INPUT_SEQS(i,1);
        end 
       
    end
end
%  TOTALCOST = TOTALCOST+ best_util;
  
%%
 %SEGMENT 2
 fx = zeros(rc_LOOKAHEAD_STEPS, rc_STATE_SIZE); % 1*x array

best_util  = -Inf; % initialize the best_util to be minus infinity
v(1,3) = rc_INPUT_SEQS(1,1);

est_ein = rc_einPredict2();

cx = [cm(9) cm(3) cm(15)];  % current state

for i = 1:rc_IN_TRACES_NO,
    fx(1,:) = cx;
    valid_set = 1;
    
    for j = 1:rc_LOOKAHEAD_STEPS,
        if rc_isValidInput(fx(j,:), rc_INPUT_SEQS(i,j)) == 1, % no use this line since the return value is always 1
            fx(j+1,:) = rc_sysModel2(fx(j,:), rc_INPUT_SEQS(i,j), est_ein(j));
            
            if rc_isValidState(fx(j+1,:)), % no use this line since the return value is always 1
              
                continue;
            end
        end
        valid_set = 0;
        break;
    end
    
    if valid_set == 1,
       current_u = cm(15);
        cur_util = rc_sysCost(fx,current_u);
         
        if cur_util(1) > best_util
            best_util = cur_util(1);
           
            v(1,3) = rc_INPUT_SEQS(i,1);
        end 
       
    end
end
%TOTALCOST = TOTALCOST + best_util;

%%
%SEGMENT 3
fx = zeros(rc_LOOKAHEAD_STEPS, rc_STATE_SIZE); % 1*x array

best_util  = -Inf; % initialize the best_util to be minus infinity
v(1,4) = rc_INPUT_SEQS(1,1);

est_ein = rc_einPredict3();

cx = [cm(10) cm(4) cm(16)];  % current state

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
       current_u = cm(16);
        cur_util = rc_sysCost(fx,current_u);
         
        if cur_util(1) > best_util
            best_util = cur_util(1);
           
            v(1,4) = rc_INPUT_SEQS(i,1);
        end 
       
    end
end

 %   TOTALCOST = TOTALCOST + best_util;
    
 %%
 % SEGMENT 4
 fx = zeros(rc_LOOKAHEAD_STEPS, rc_STATE_SIZE); % 1*x array

best_util  = -Inf; % initialize the best_util to be minus infinity
v(1,5) = rc_INPUT_SEQS(1,1);

est_ein = rc_einPredict4();

cx = [cm(11) cm(5) cm(17)];  % current state

for i = 1:rc_IN_TRACES_NO,
    fx(1,:) = cx;
    valid_set = 1;
    
    for j = 1:rc_LOOKAHEAD_STEPS,
        if rc_isValidInput(fx(j,:), rc_INPUT_SEQS(i,j)) == 1, % no use this line since the return value is always 1
            fx(j+1,:) = rc_sysModel4(fx(j,:), rc_INPUT_SEQS(i,j), est_ein(j));
            
            if rc_isValidState(fx(j+1,:)), % no use this line since the return value is always 1
              
                continue;
            end
        end
        valid_set = 0;
        break;
    end
   
   if valid_set == 1,
       current_u = cm(17);
        cur_util = rc_sysCost(fx,current_u);
         
        if cur_util(1) > best_util
            best_util = cur_util(1);
           
            v(1,5) = rc_INPUT_SEQS(i,1);
        end 
       
    end
end
%TOTALCOST = TOTALCOST + best_util;

%%
%SEGMENT 5

fx = zeros(rc_LOOKAHEAD_STEPS, rc_STATE_SIZE); % 1*x array

best_util  = -Inf; % initialize the best_util to be minus infinity
v(1,6) = rc_INPUT_SEQS(1,1);

est_ein = rc_einPredict5();
cx = [cm(12) cm(6) cm(18)];  % current state

for i = 1:rc_IN_TRACES_NO,
    fx(1,:) = cx;
    valid_set = 1;
    
    for j = 1:rc_LOOKAHEAD_STEPS,
        if rc_isValidInput(fx(j,:), rc_INPUT_SEQS(i,j)) == 1, % no use this line since the return value is always 1
            fx(j+1,:) = rc_sysModel5(fx(j,:), rc_INPUT_SEQS(i,j), est_ein(j));
            
            if rc_isValidState(fx(j+1,:)), % no use this line since the return value is always 1
              
                continue;
            end
        end
        valid_set = 0;
        break;
    end
   
   if valid_set == 1,
       current_u = cm(18);
        cur_util = rc_sysCost_big(fx,current_u);
         
        if cur_util(1) > best_util
            best_util = cur_util(1);
           
            v(1,6) = rc_INPUT_SEQS(i,1);
        end 
       
    end
end
%TOTALCOST = TOTALCOST + best_util;


