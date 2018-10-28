#!/bin/bash

echo "Waiting 40 sec for network creation"

sleep 40 #time for network creation

while true
do

    sleep 300 #Launching all the scripts every 5 min

    echo "Launching test scripts"

    echo "inter_rounting_test.sh"
    /home/vagrant/lingi2142/monit_tests/inter_routing_test.sh >> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/ospf_logs.txt

    echo "bgp_test.sh"
    /home/vagrant/lingi2142/monit_tests/bgp_test.sh >> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/bgp_logs.txt

    echo "ping_bgp.sh"
    /home/vagrant/lingi2142/monit_tests/ping_bgp.sh >> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/bgp_logs.txt

    echo "launch_snmp.sh"
    /home/vagrant/lingi2142/monit_tests/launch_snmp.sh >> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/snmp_logs.txt

    echo "check_link_failure.sh"
    /home/vagrant/lingi2142/monit_tests/check_link_failure.sh >> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/interfaces_logs.txt

    echo "dns_test.sh"
    /home/vagrant/lingi2142/monit_tests/dns_test.sh >> /home/vagrant/lingi2142/gr4_cfg/MONI/logs/dns_logs.txt
done