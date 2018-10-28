import os, inspect, sys, time, subprocess
curdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
pardir = os.path.dirname(curdir)
sys.path.insert(0,pardir)
from tests import helpers

#Testing if network is set by pinging from STEV to HALL during 5 min, after that we estimate than there's an error in the network creation

starttime = int(round(time.time()))

kword = "100%"

while kword == "100%"  and (int(round(time.time())) - starttime < 300):
	cmd = helpers.execute("sudo ip netns exec STEV ping6 -w 2 -q fd00:300:4:f24::2") #Try to ping HALL
        if not cmd == "":
        	lines = cmd.split("\n")
		line = lines[3].split(" ")
		kword = line[7]

if kword == "100%":
	print("Network still not set up after 5 minutes")
else:
	print("Network is up ! Launching scripts...")
	subprocess.Popen("sudo /home/vagrant/lingi2142/monit_tests/script_launcher.sh", shell=True)

