#!/bin/bash

puppet apply --verbose --parser future --hiera_config=/etc/puppet/hiera.yaml /etc/puppet/site.pp --modulepath=/puppetmodules
<<<<<<< HEAD:ucl_minimal_cfg/CARN_start.sh
ip addr add dev CARN-lan0 fd00:300:4:e10::/64
=======

ip addr add dev CARN-lan0 fd00:300:4:e11::/64 
named
radvd
>>>>>>> origin/dev:gr4_cfg/CARN_start.sh
