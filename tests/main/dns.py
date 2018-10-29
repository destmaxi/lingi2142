import unittest
import os, sys, inspect
curdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
pardir = os.path.dirname(curdir)
sys.path.insert(0,pardir)
from helpers import *
import helpers

class TestDDNS(unittest.TestCase):
	def test_servail(self):
		helpers.entete('Check if a dig return a servail error')
		output = execute('../../monit_tests/dns_test.sh')
		self.assertEquals(-1, output.find('SERVFAIL'))
	def test_nxdomain(self):
		helpers.entete('Check if a dig return a nxdomain error')
		output = execute('../../monit_tests/dns_test.sh')
		self.assertEquals(-1, output.find('NXDOMAIN'))

if __name__ == '__main__':
	unittest.main(verbosity=2)
