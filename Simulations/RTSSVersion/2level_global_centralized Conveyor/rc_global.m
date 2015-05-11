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

global rc_LOOKAHEAD_STEPS_G
global rc_INPUT_SEQS_G
global rc_IN_TRACES_NO_G

global rc_INPUT_SET_BIG
global rc_LOOKAHEAD_STEPS_BIG
global rc_INPUT_SEQS_BIG
global rc_IN_TRACES_NO_BIG

global rc_STATE_SIZE
global rc_INPUT_SET
global rc_LOOKAHEAD_STEPS
global rc_INPUT_SEQS
global rc_IN_TRACES_NO

global rc_LOOKAHEAD_STEP_GLOBAL_CHANGE
global rc_LONG_TERM_RANGE
global TOTALCOST

for init = 1:6
    v(1,init) =1;
end


if  rc_GLOBAL_TIME <= rc_LONG_TERM_RANGE && rc_GLOBAL_TIME > 0 && rc_CTIME > 10

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

if  rc_GLOBAL_TIME > 60   
    avg_q = (mean(q_level) + mean(q1_level) + mean(q2_level) + mean(q3_level) + mean(q4_level))/5;
    avg_y = (mean(y_level) + mean(y1_level) + mean(y2_level) + mean(y3_level) + mean(y4_level))/5;
    avg_u = (mean(u_level) + mean(u1_level) + mean(u2_level) + mean(u3_level) + mean(u4_level))/5;
    avg_ar = (mean(ar_level) + mean(ar1_level) + mean(ar2_level) + mean(ar3_level) + mean(ar4_level))/5;
    
    cx = [avg_q avg_y avg_u];  % current 60 min state
    cur_util = zeros(1,7);
    best_util  = -Inf; % initialize the best_util to be minus infinity
    for i = 1:rc_IN_TRACES_NO_G,
        fx(1,:) = cx;
        valid_set = 1;

        for j = 1:rc_LOOKAHEAD_STEPS_G,
            if rc_isValidInput(fx(j,:), rc_INPUT_SEQS_G(i,j)) == 1, % no use this line since the return value is always 1
                fx(j+1,:) = rc_sysModel(fx(j,:), rc_INPUT_SEQS_G(i,j), avg_ar);

                if rc_isValidState(fx(j+1,:)), % no use this line since the return value is always 1

                    continue;
                end
            end
            valid_set = 0;
            break;
        end

        if valid_set == 1,
          
            cur_util(1,i) = rc_sysCost_global(fx,avg_u);
            if cur_util(1,i) > best_util
                best_util = cur_util(1);
                index = i;
            end
        end
    end
    
    if index == 1
         rc_INPUT_SET = [0.2564  0.3479];
         rc_LOOKAHEAD_STEPS = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
         rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
         
    end
    
    if index == 2
         rc_INPUT_SET = [0.2564  0.3479  0.4349];
         rc_LOOKAHEAD_STEPS = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
         rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
       
    end
    
    if index == 3
         rc_INPUT_SET = [0.3479  0.4349 0.5219];
         rc_LOOKAHEAD_STEPS = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
         rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
         
    end
    
    if index == 4
         rc_INPUT_SET = [0.4349 0.5219 0.650];
         rc_LOOKAHEAD_STEPS = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
         rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
         
    end   
    
    if index == 5
         rc_INPUT_SET = [0.5219 0.650 0.7829];
         rc_LOOKAHEAD_STEPS = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
         rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
         
    end     
    
    if index == 6
         rc_INPUT_SET = [0.650 0.7829 1.0000];
         rc_LOOKAHEAD_STEPS = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
         rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
         
    end  
    
    if index == 7
         rc_INPUT_SET = [0.7829 1.0000];
         rc_LOOKAHEAD_STEPS = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
         rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
       
    end     
    
    avg_q_big = mean(q5_level);
    avg_y_big = mean(y5_level);
    avg_u_big = mean(u5_level);
    avg_ar_big =mean(ar5_level);
    
    cx_big = [avg_q_big avg_y_big avg_u_big];  % current 60 min state
    cur_util_big = zeros(1,7);
    best_util  = -Inf; % initialize the best_util to be minus infinity
    index = 0;
    for i = 1:rc_IN_TRACES_NO_G,
        fx_big(1,:) = cx_big;
        valid_set = 1;

        for j = 1:rc_LOOKAHEAD_STEPS_G,
            if rc_isValidInput(fx_big(j,:), rc_INPUT_SEQS_G(i,j)) == 1, % no use this line since the return value is always 1
                fx_big(j+1,:) = rc_sysModel5(fx_big(j,:), rc_INPUT_SEQS_G(i,j), avg_ar_big);

                if rc_isValidState(fx_big(j+1,:)), % no use this line since the return value is always 1

                    continue;
                end
            end
            valid_set = 0;
            break;
        end

        if valid_set == 1,
            cur_util_big(1,i) = rc_sysCost_big_global(fx_big,avg_u_big);
            if cur_util_big(1,i) > best_util
                best_util = cur_util_big(1);
                index = i;
            end

        end
    end
   
     if index == 1
         rc_INPUT_SET_BIG = [0.2564  0.3479];
         rc_LOOKAHEAD_STEPS_BIG = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS_BIG = cartprod(rc_INPUT_SET_BIG, rc_LOOKAHEAD_STEPS_BIG);
         rc_IN_TRACES_NO_BIG = size(rc_INPUT_SEQS_BIG, 1);
         
    end
    
    if index == 2
         rc_INPUT_SET_BIG = [0.2564  0.3479  0.4349];
          rc_LOOKAHEAD_STEPS_BIG = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS_BIG = cartprod(rc_INPUT_SET_BIG, rc_LOOKAHEAD_STEPS_BIG);
         rc_IN_TRACES_NO_BIG = size(rc_INPUT_SEQS_BIG, 1);
       
    end
    
    if index == 3
         rc_INPUT_SET_BIG = [0.3479  0.4349 0.5219];
         rc_LOOKAHEAD_STEPS_BIG = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS_BIG = cartprod(rc_INPUT_SET_BIG, rc_LOOKAHEAD_STEPS_BIG);
         rc_IN_TRACES_NO_BIG = size(rc_INPUT_SEQS_BIG, 1);
         
    end
    
    if index == 4
         rc_INPUT_SET_BIG = [0.4349 0.5219 0.650];
         rc_LOOKAHEAD_STEPS_BIG = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS_BIG = cartprod(rc_INPUT_SET_BIG, rc_LOOKAHEAD_STEPS_BIG);
         rc_IN_TRACES_NO_BIG = size(rc_INPUT_SEQS_BIG, 1);
  
    end   
    
    if index == 5
         rc_INPUT_SET_BIG = [0.5219 0.650 0.7829];
          rc_LOOKAHEAD_STEPS_BIG = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS_BIG = cartprod(rc_INPUT_SET_BIG, rc_LOOKAHEAD_STEPS_BIG);
         rc_IN_TRACES_NO_BIG = size(rc_INPUT_SEQS_BIG, 1);
        
    end     
    
    if index == 6
         rc_INPUT_SET_BIG = [0.650 0.7829 1.0000];
         rc_LOOKAHEAD_STEPS_BIG = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS_BIG = cartprod(rc_INPUT_SET_BIG, rc_LOOKAHEAD_STEPS_BIG);
         rc_IN_TRACES_NO_BIG = size(rc_INPUT_SEQS_BIG, 1);
         
    end  
    
    if index == 7
         rc_INPUT_SET_BIG = [0.7829 1.0000];
         rc_LOOKAHEAD_STEPS_BIG = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS_BIG = cartprod(rc_INPUT_SET_BIG, rc_LOOKAHEAD_STEPS_BIG);
         rc_IN_TRACES_NO_BIG = size(rc_INPUT_SEQS_BIG, 1);
        
    end     
    
   rc_GLOBAL_TIME = 0;
    
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
 TOTALCOST = TOTALCOST + best_util;

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
  TOTALCOST = TOTALCOST+ best_util;
  
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
TOTALCOST = TOTALCOST + best_util;

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

    TOTALCOST = TOTALCOST + best_util;
    
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
TOTALCOST = TOTALCOST + best_util;

%%
%SEGMENT 5

fx = zeros(rc_LOOKAHEAD_STEPS_BIG, rc_STATE_SIZE); % 1*x array

best_util  = -Inf; % initialize the best_util to be minus infinity
v(1,6) = rc_INPUT_SEQS_BIG(1,1);

est_ein = rc_einPredict5();
cx = [cm(12) cm(6) cm(18)];  % current state

for i = 1:rc_IN_TRACES_NO_BIG,
    fx(1,:) = cx;
    valid_set = 1;
    
    for j = 1:rc_LOOKAHEAD_STEPS_BIG,
        if rc_isValidInput(fx(j,:), rc_INPUT_SEQS_BIG(i,j)) == 1, % no use this line since the return value is always 1
            fx(j+1,:) = rc_sysModel5(fx(j,:), rc_INPUT_SEQS_BIG(i,j), est_ein(j));
            
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
           
            v(1,6) = rc_INPUT_SEQS_BIG(i,1);
        end 
       
    end
end
TOTALCOST = TOTALCOST + best_util;