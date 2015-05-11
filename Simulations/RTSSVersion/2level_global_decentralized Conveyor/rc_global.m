function v = rc_global(u)

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

global rc_INPUT_SET
global rc_LOOKAHEAD_STEPS
global rc_INPUT_SEQS
global rc_IN_TRACES_NO

global rc_LOOKAHEAD_STEP_GLOBAL_CHANGE
global rc_LONG_TERM_RANGE

v(3) = 0;


if  rc_GLOBAL_TIME <= rc_LONG_TERM_RANGE && rc_GLOBAL_TIME > 0 && rc_CTIME > 10

    q_level(rc_GLOBAL_TIME)  = u(7) ;
    q1_level(rc_GLOBAL_TIME) = u(8) ;
    q2_level(rc_GLOBAL_TIME) = u(9) ;
    q3_level(rc_GLOBAL_TIME) = u(10) ;
    q4_level(rc_GLOBAL_TIME) = u(11) ;
    q5_level(rc_GLOBAL_TIME) = u(12) ;
    
    y_level(rc_GLOBAL_TIME)  = u(1) ;
    y1_level(rc_GLOBAL_TIME) = u(2) ;
    y2_level(rc_GLOBAL_TIME) = u(3) ;
    y3_level(rc_GLOBAL_TIME) = u(4) ;
    y4_level(rc_GLOBAL_TIME) = u(5) ;
    y5_level(rc_GLOBAL_TIME) = u(6) ;
    
    u_level(rc_GLOBAL_TIME)  = u(13) ;
    u1_level(rc_GLOBAL_TIME) = u(14) ;
    u2_level(rc_GLOBAL_TIME) = u(15) ;
    u3_level(rc_GLOBAL_TIME) = u(16) ;
    u4_level(rc_GLOBAL_TIME) = u(17) ;
    u5_level(rc_GLOBAL_TIME) = u(18) ;
    
    ar_level(rc_GLOBAL_TIME)  = u(19) ;
    ar1_level(rc_GLOBAL_TIME) = u(20) ;
    ar2_level(rc_GLOBAL_TIME) = u(21) ;
    ar3_level(rc_GLOBAL_TIME) = u(22) ;
    ar4_level(rc_GLOBAL_TIME) = u(23) ;
    ar5_level(rc_GLOBAL_TIME) = u(24) ;
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
         v(3) = 1;
    end
    
    if index == 2
         rc_INPUT_SET = [0.2564  0.3479  0.4349];
         rc_LOOKAHEAD_STEPS = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
         rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
         v(3) = 1;
    end
    
    if index == 3
         rc_INPUT_SET = [0.3479  0.4349 0.5219];
         rc_LOOKAHEAD_STEPS = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
         rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
         v(3) = 1;
    end
    
    if index == 4
         rc_INPUT_SET = [0.4349 0.5219 0.650];
         rc_LOOKAHEAD_STEPS = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
         rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
         v(3) = 1;
    end   
    
    if index == 5
         rc_INPUT_SET = [0.5219 0.650 0.7829];
         rc_LOOKAHEAD_STEPS = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
         rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
         v(3) = 1;
    end     
    
    if index == 6
         rc_INPUT_SET = [0.650 0.7829 1.0000];
         rc_LOOKAHEAD_STEPS = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
         rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
         v(3) = 1;
    end  
    
    if index == 7
         rc_INPUT_SET = [0.7829 1.0000];
         rc_LOOKAHEAD_STEPS = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS = cartprod(rc_INPUT_SET, rc_LOOKAHEAD_STEPS);
         rc_IN_TRACES_NO = size(rc_INPUT_SEQS, 1);
         v(3) = 1;
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
         v(3) = 1;
    end
    
    if index == 2
         rc_INPUT_SET_BIG = [0.2564  0.3479  0.4349];
          rc_LOOKAHEAD_STEPS_BIG = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS_BIG = cartprod(rc_INPUT_SET_BIG, rc_LOOKAHEAD_STEPS_BIG);
         rc_IN_TRACES_NO_BIG = size(rc_INPUT_SEQS_BIG, 1);
         v(3) = 1;
    end
    
    if index == 3
         rc_INPUT_SET_BIG = [0.3479  0.4349 0.5219];
         rc_LOOKAHEAD_STEPS_BIG = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS_BIG = cartprod(rc_INPUT_SET_BIG, rc_LOOKAHEAD_STEPS_BIG);
         rc_IN_TRACES_NO_BIG = size(rc_INPUT_SEQS_BIG, 1);
         v(3) = 1;
    end
    
    if index == 4
         rc_INPUT_SET_BIG = [0.4349 0.5219 0.650];
         rc_LOOKAHEAD_STEPS_BIG = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS_BIG = cartprod(rc_INPUT_SET_BIG, rc_LOOKAHEAD_STEPS_BIG);
         rc_IN_TRACES_NO_BIG = size(rc_INPUT_SEQS_BIG, 1);
         v(3) = 1;
    end   
    
    if index == 5
         rc_INPUT_SET_BIG = [0.5219 0.650 0.7829];
          rc_LOOKAHEAD_STEPS_BIG = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS_BIG = cartprod(rc_INPUT_SET_BIG, rc_LOOKAHEAD_STEPS_BIG);
         rc_IN_TRACES_NO_BIG = size(rc_INPUT_SEQS_BIG, 1);
         v(3) = 1;
    end     
    
    if index == 6
         rc_INPUT_SET_BIG = [0.650 0.7829 1.0000];
         rc_LOOKAHEAD_STEPS_BIG = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS_BIG = cartprod(rc_INPUT_SET_BIG, rc_LOOKAHEAD_STEPS_BIG);
         rc_IN_TRACES_NO_BIG = size(rc_INPUT_SEQS_BIG, 1);
         v(3) = 1;
    end  
    
    if index == 7
         rc_INPUT_SET_BIG = [0.7829 1.0000];
         rc_LOOKAHEAD_STEPS_BIG = rc_LOOKAHEAD_STEP_GLOBAL_CHANGE; 
         rc_INPUT_SEQS_BIG = cartprod(rc_INPUT_SET_BIG, rc_LOOKAHEAD_STEPS_BIG);
         rc_IN_TRACES_NO_BIG = size(rc_INPUT_SEQS_BIG, 1);
         v(3) = 1;
    end     
    
   rc_GLOBAL_TIME = 0;
    
end

v(1) = rc_GLOBAL_TIME ;
v(2) = rc_IN_TRACES_NO; 
