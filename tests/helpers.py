import os, sys
import subprocess

def execute(command):
	p = subprocess.Popen( command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
	output, err = p.communicate()
	return output.decode("utf-8")

def title(arg):
	print(
"######################################################################")
	print("#			  Test the %s			     #" % (arg))
	print("######################################################################")

def entete(text):
	print()
	print("#")
	print("# %s" % (text))
	print("#")
	print("... ")
