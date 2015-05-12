% system composite-style utility function 

function J = rc_sysUtility(next_x)


global q_max
global rc_LOOKAHEAD_STEPS
global alpha
global a1
global a2
global a3
global index
global rc_CTIME

%costMatrix = temp * Q1;

%J(1) =  min (min(costMatrix));
%costMatrix = -x1*10^-11 + x2*5*10^-5+ x3*10^-2;
%costMatrix = -x1/(800*800) + x2/(700*700) + x3/700;

% when i = 1, it is just the current input
J_temp = 0;
for i = 2: rc_LOOKAHEAD_STEPS+1,

    q  = next_x(i,1);
    y  = next_x(i,2);
    ec = next_x(i,3);

    x1 = ec*ec;
    x2 = y*y;
    x3 = (q-q_max);
    if(q<=q_max)
      x3 = 0;
    end
    
    
    temp(1) = x1;
    temp(2) = x2;
    temp(3) = x3;
    
    a = temp(1);
    
    %if(rc_CTIME < 2450 && rc_CTIME > 2300)  
        a1(index) = -nthroot(x1/(1000*1000*1000*1000*alpha*alpha),4);
        a2(index) =  nthroot(x2/(716*716),2);
       
        a3(index) = x3/1500;
        index = index + 1;
  %  end
%    
%   costMatrix =  -sqrt(ec) + y-q;
 % costMatrix = -nthroot(abs(x1-256*256*256*256)/(1000*1000*1000*1000*alpha*alpha),4) + x2/(1000*1000) - x3/1500;
  costMatrix= -(x1)/(1000*1000*1000*1000*alpha*alpha) + (x2)/(1000*1000) - x3/744*7/1000;
%   costMatrix = -x1/(1000*1000*1000*1000*alpha*alpha) + x2/(1000*1000) + x3/1500;
 
   J_temp = J_temp + costMatrix;
end
if rc_CTIME == 50
    v = nthroot(ec/alpha,2)
    costMatrix
end
J = J_temp;