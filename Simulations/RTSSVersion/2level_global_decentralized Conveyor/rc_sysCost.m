% system composite-style utility function 

function J = rc_sysCost(next_x, current_u)

global rc_LOOKAHEAD_STEPS
global alpha

% when i = 1, it is just the current input
J_temp = 0;
for i = 2: rc_LOOKAHEAD_STEPS+1,

    adjust_u = next_x(i,1);
    y  = next_x(i,2);
    ec = next_x(i,3);

    x1 = ec*ec;
    x2 = y*y;
    x3 = abs(current_u-adjust_u);

  costMatrix = -(x1)/(1000*1000*1000*1000*alpha*alpha) + (x2)/(1000*1000)-x3/774*7/1000;
 

 
   J_temp = J_temp + costMatrix;
end

J = J_temp;