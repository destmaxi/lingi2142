#!/bin/bash

puppet apply --verbose --parser future --hiera_config=/etc/puppet/hiera.yaml /etc/puppet/site.pp --modulepath=/puppetmodules


ip link set dev MONI-eth0 up
ip addr add dev MONI-eth0 fd00:300:4:e10::2/64
ip -6 route add ::/0 via fd00:300:4:e10::

#./ MONI/check_OSPF.sh >

echo 'wazaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa------------------------------------------------------------------'
sh ucl_minimal_cfg/MONI/check_test.sh >> ucl_minimal_cfg/MONI/logs.txt