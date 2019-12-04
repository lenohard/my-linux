import sys;
s = sys.stdin.readlines();
print "from stdin:", s;
t = open("/dev/tty", "r");
s = t.readline();
print "from tty:", s;
