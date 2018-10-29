#!/bin/bash

sleep 10 #add some time just to be sure about the network creation

while true
do
    /home/vagrant/lingi2142/monit_tests/inter_routing_test.sh 1>> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/ospf_logs.txt 2>/dev/null

    /home/vagrant/lingi2142/monit_tests/bgp_test.sh 1>> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/bgp_logs.txt 2>/dev/null

    /home/vagrant/lingi2142/monit_tests/ping_bgp.sh 1>> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/bgp_logs.txt 2>/dev/null

    /home/vagrant/lingi2142/monit_tests/launch_snmp.sh 1>> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/snmp_logs.txt2>/dev/null

    /home/vagrant/lingi2142/monit_tests/dns_test.sh 1>> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/dns_logs.txt 2>/dev/null

    sleep 300 #Launching all the scripts every 5 min

done
