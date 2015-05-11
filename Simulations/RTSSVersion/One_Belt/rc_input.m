function v = rc_input(u)

global rc_CTIME
global ein
global randomWorkload
global xxx
global yyy
v = 300;

if rc_CTIME < 100
    v = 1000
end

if rc_CTIME > 101 && rc_CTIME <= 9000
    v = [ ein(rc_CTIME) ];
end


rc_CTIME = rc_CTIME + 1;