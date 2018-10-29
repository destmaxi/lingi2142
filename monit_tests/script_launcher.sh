#!/bin/bash

sleep 10 #add some time just to be sure about the network creation

while true
do
    /home/vagrant/lingi2142/monit_tests/inter_routing_test.sh >> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/ospf_logs.txt

    /home/vagrant/lingi2142/monit_tests/bgp_test.sh >> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/bgp_logs.txt

    /home/vagrant/lingi2142/monit_tests/ping_bgp.sh >> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/bgp_logs.txt

    /home/vagrant/lingi2142/monit_tests/launch_snmp.sh >> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/snmp_logs.txt

    #echo "check_link_failure.sh"
    #/home/vagrant/lingi2142/monit_tests/check_link_failure.sh >> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/interfaces_logs.txt

    #echo "dns_test.sh"
    #/home/vagrant/lingi2142/monit_tests/dns_test.sh >> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/dns_logs.txt

    sleep 300 #Launching all the scripts every 5 min

done
