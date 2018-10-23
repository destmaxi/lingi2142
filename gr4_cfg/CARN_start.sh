#!/bin/bash

puppet apply --verbose --parser future --hiera_config=/etc/puppet/hiera.yaml /etc/puppet/site.pp --modulepath=/puppetmodules

ip addr add dev CARN-lan0 fd00:300:4:e11::/64 
named
radvd
