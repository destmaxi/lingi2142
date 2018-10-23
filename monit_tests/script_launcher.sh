#!/bin/bash

echo "Launching test scripts"

./bgp_test.sh >> /home/vagrant/lingi2142/ucl_minimal_cfg/MONI/logs/bgp_logs.txt

./inter_routing_test.sh >> /home/vagrant/lingi2142/ucl_minimal_cfg/MONI/logs/ospf_logs.txt 
 
./check_link_failure.sh >> /home/vagrant/lingi2142/ucl_minimal_cfg/MONI/logs/interfaces_logs.txt 

