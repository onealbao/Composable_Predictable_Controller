function v = rc_output(u)

global rc_CTIME
persistent total

if rc_CTIME == 0
    v = [0];
else
    
x = u(1);
cur_total = total(1);
v = [ x + cur_total];
end
total = v;