#!/bin/bash

puppet apply --verbose --parser future --hiera_config=/etc/puppet/hiera.yaml /etc/puppet/site.pp --modulepath=/puppetmodules
ip addr add fd00:300::4/48 dev Halles-eth1
