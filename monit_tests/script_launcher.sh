#!/bin/bash

echo "Launching test scripts"

echo "bgp_test.sh"
/home/vagrant/lingi2142/monit_tests/bgp_test.sh >> /home/vagrant/lingi2142/ucl_minimal_cfg/MONI/logs/bgp_logs.txt

echo "inter_rounting_test.sh"
/home/vagrant/lingi2142/monit_tests/inter_routing_test.sh >> /home/vagrant/lingi2142/ucl_minimal_cfg/MONI/logs/ospf_logs.txt

echo "check_link_failure.sh"
/home/vagrant/lingi2142/monit_tests/check_link_failure.sh >> /home/vagrant/lingi2142/ucl_minimal_cfg/MONI/logs/interfaces_logs.txt

echo "launch_snmp.sh"
/home/vagrant/lingi2142/monit_tests/launch_snmp.sh >> /home/vagrant/lingi2142/ucl_minimal_cfg/MONI/logs/snmp_logs.txt
