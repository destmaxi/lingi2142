import unittest
import subprocess

google = "2a00:1450:400e:80c::2003"
STUD1  = "fd00:300:4:b40::1"
ADMI1  = "fd00:300:4:a30::2"
MICH   = "fd00:300:4:f31::3"

def execute(command):
	p = subprocess.Popen( command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
	output, err = p.communicate()
	return output.decode("utf-8")


class TestFirewall(unittest.TestCase):
	def deleteUselessLines(self, l):
		for i in l:
			if len(i) < 4 or i[2] in {"open, closed, filtered"}:
				l.remove(i)
	

	def checkStatus(self, status):
		for port in status:
			if port in {"open", "closed"}:
				return True
		return False
	
	def entete(self, text):
		print()
		print("#")
		print("# %s" % (text)) 
		print("#")
		print("... ")
		

	def test_open_TCP_ports_student(self):
		self.entete("Test tcp ports 80, 443 from a student towards an external server")
		count = 0
		output = execute("sudo ip netns exec STUD1 nmap -6 -Pn T:80,443 %s" % (google))
		list_results = output.split("\n")
		self.deleteUselessLines(list_results)

		for port in list_results:
			getStatus = port.split(" ")
			if self.checkStatus(getStatus):
				count += 1
		
		self.assertEqual(count, 2)
	
	def test_student_not_host(self):
		self.entete("Ensure that a student can't host a service")
		output = execute("sudo ip netns exec MAX nmap -6 -Pn T:22 %s" % (STUD1))
		list_results = output.split("\n")
		self.deleteUselessLines(list_results)

		result = self.checkStatus(list_results[0].split(" "))
		self.assertFalse(result)

	def test_router_not_reachable_from_student(self):
		self.entete("Ensure that a student can't send traffic towards a router")
		output = execute("sudo ip netns exec STUD1 nmap -6 -Pn -p T:80 %s" % (MICH))
		list_results = output.split("\n")
		self.deleteUselessLines(list_results)

		result = self.checkStatus(list_results[0].split(" "))
		self.assertFalse(result)

if __name__ == '__main__':
	print(
"######################################################################")
	print("#			  Test the Firewall			     #")
	print("######################################################################")
	unittest.main(verbosity=2)


