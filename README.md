################################################################################
#                         How to run this network                              #
################################################################################

This file explains how to run this network.
Normally all the dependencies are well installed but if they don't (error while launching the network) you can refer to the @dependdencies section.


################################################################################
#                              Building the vm                                 #
################################################################################

To build the vm you need to install virtualbox, vagrant and the plugin vargant-vbguest on your computer. Open a terminal and execute the following command:

  $ vagrant up

To create the vm and then you can log in the vm with ssh like this:

  $ vagrant ssh

Normally all dependencies and tools are installed but if they don't you can (again) refer to the @dependdencies section.


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

once inside a router, server or lan you can run any command that you want.


################################################################################
#                               Test the network                               #
################################################################################

Before testing the network make shure you wait enough time (+- 1min), the network has to configure itselfs.

To test the all network you can just run:

  $ make test all_tests

You can also spécify a target (ex: firewall), if you are not shure about which targets exists please run:

  $ make test help

Or refer to the README.md in the tests/ repository


################################################################################
#                                dependencies                                  #
################################################################################

Normally the provision file should download all the necessary files. If it is not the case you can try to download them manually.

  $ apt-get -y -qq --force-yes install git bash vim-nox tcpdump nano bird6 quagga inotify-tools iperf bind9 radvd puppet nmap
