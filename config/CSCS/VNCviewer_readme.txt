TO LAUNCH A VIRTUAL DESKTOP ON DAINT :

1) vncserver initialization :
  > vncserver -geometry 1680x1050

output :
New 'X' desktop is daint101:6
Starting applications specified in /users/gjeusel/.vnc/xstartup
Log file is /users/gjeusel/.vnc/daint101:6.log

2) connect to this vncserver, don't forget to change daintxxx:x :
  > /usr/bin/vncserver daint101:6

3) Kill it when finished :
  > vncserver -kill daint101:6
