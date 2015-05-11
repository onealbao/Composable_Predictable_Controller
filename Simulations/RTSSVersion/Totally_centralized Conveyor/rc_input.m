function v = rc_input(u)

global rc_CTIME
global ein
global rc_GLOBAL_TIME
v = [300];
if rc_CTIME > 0 && rc_CTIME <= 9000
    v = [ ein(rc_CTIME) ];
end


rc_CTIME = rc_CTIME + 1;
rc_GLOBAL_TIME = rc_GLOBAL_TIME + 1;
