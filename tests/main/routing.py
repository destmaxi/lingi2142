import unittest
import os, inspect, sys
curdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
pardir = os.path.dirname(curdir)
sys.path.insert(0,pardir)
from helpers import *
import helpers
import time

class Testrouting(unittest.TestCase):

    def test_ping_everything_from_CARN(self):
        helpers.entete("Ping toutes les interfaces depuis CARN")
        output = execute("sudo ip netns exec CARN ./etc/script/script.sh %s")
        self.assertFalse(output!="")

    def test_ping_everything_from_HALL(self):
        helpers.entete("Ping toutes les interfaces depuis HALL")
        output = execute("sudo ip netns exec HALL ./etc/script/script.sh %s")
        self.assertFalse(output!="")

    def test_ping_everything_from_MICH(self):
        helpers.entete("Ping toutes les interfaces depuis MICH")
        output = execute("sudo ip netns exec MICH ./etc/script/script.sh %s")
        self.assertFalse(output!="")

    def test_ping_everything_from_PYTH(self):
        helpers.entete("Ping toutes les interfaces depuis PYTH")
        output = execute("sudo ip netns exec PYTH ./etc/script/script.sh %s")
        self.assertFalse(output!="")

    def test_ping_everything_from_SH1C(self):
        helpers.entete("Ping toutes les interfaces depuis SH1C")
        output = execute("sudo ip netns exec SH1C ./etc/script/script.sh %s")
        self.assertFalse(output!="")

    def test_ping_everything_from_STEV(self):
        helpers.entete("Ping toutes les interfaces depuis STEV")
        output = execute("sudo ip netns exec STEV ./etc/script/script.sh %s")
        self.assertFalse(output!="")

    def test_tunnel(self):
        helpers.entete("Set inteface HALL-eth1 down")
        output = execute("sudo ip netns exec HALL ip link set HALL-eth1 down %s")
        helpers.entete("We wait 30 secondes to let OSPF modify the routing's tables")
        time.sleep(30)
        helpers.entete("We ping every routers and pop from every routers")
        output = execute("sudo ip netns exec CARN ./etc/script/script.sh %s")
        self.assertEqual(output.count('\n'),2) #2 because they will be 2 error to ping the 2 addresses of HALL-eth1
        output = execute("sudo ip netns exec HALL ./etc/script/script.sh %s")
        self.assertEqual(output.count('\n'),2)
        output = execute("sudo ip netns exec MICH ./etc/script/script.sh %s")
        self.assertEqual(output.count('\n'),2)
        output = execute("sudo ip netns exec PYTH ./etc/script/script.sh %s")
        self.assertEqual(output.count('\n'),2)
        output = execute("sudo ip netns exec SH1C ./etc/script/script.sh %s")
        self.assertEqual(output.count('\n'),2)
        output = execute("sudo ip netns exec STEV ./etc/script/script.sh %s")
        self.assertEqual(output.count('\n'),2)
        helpers.entete("Set inteface HALL-eth1 up")
        output = execute("sudo ip netns exec HALL /etc/static_routes.conf/static_routes.sh 2> /dev/null")

if __name__ == '__main__':
	unittest.main(verbosity=2)
