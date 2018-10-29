################################################################################
#                              Building the VM                                 #
################################################################################

To build the VM you need to install virtualbox, vagrant and the plugin vargant-vbguest on your computer. Open a terminal and execute the following command:

  $ vagrant up --provision

The --provision is important, without that the dependencies won't be installed 
To create the VM and then you can log in the VM with ssh like this:

  $ vagrant ssh

Normally all dependencies and tools are installed but if they don't you can (again) refer to the @dependencies section.


################################################################################
#                         How to run this network                              #
################################################################################

This file explains how to run this network.
You will need to install manually snmp-mibs-downloader so please follow the following steps:
  1. go to /etc/apt/
  2. open the file sources.list
  3. add the following lines at the end of the file:
    - deb http://ftp.br.debian.org/debian/ jessie main contrib non-free
    - deb-src http://ftp.br.debian.org/debian/ jessie main contrib non-free
  4. update the VM: $ sudo apt-get update
  5. now we can install the package
    $ sudo apt-get install snmp-mibs-downloader

Normally all other dependencies are well installed but if they don't (error while launching the network) you can refer to the @dependencies section.



################################################################################
#                              Launch the network                              #
################################################################################

To launch and generate the scripts, juste move to the root directory (where the makefile is present) and run

  $ make

To stop and clean the network you just have to run the following command:

  $ make clean


################################################################################
#                                Use the network                               #
################################################################################

To connect to a particular server, router or lan you can use the following command:

  $ make connect NODE

Once inside a router, server or lan you can run any command that you want.


################################################################################
#                               Test the network                               #
################################################################################

Before testing the network make sure you wait enough time (+- 1min), the network has to configure itselfs.

To test the whole network you can just run:

  $ make test all_tests

You can also specify a target (ex: firewall). If you are not sure about which targets exist, please run:

  $ make test help

or refer to the README.md in the tests/ repository


################################################################################
#                                dependencies                                  #
################################################################################

Normally the provision file should download all the necessary files. If it is not the case you can try to download them manually.

  $ apt-get -y -qq --force-yes install git bash vim-nox tcpdump nano bird6 quagga inotify-tools iperf bind9 radvd puppet nmap
