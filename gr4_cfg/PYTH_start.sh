#!/bin/bash

puppet apply --verbose --parser future --hiera_config=/etc/puppet/hiera.yaml /etc/puppet/site.pp --modulepath=/puppetmodules

ip -6 tunnel add mytunnel mode ip6ip6 remote fd00:200:4:0f00::2
ip -6 link set mytunnel up
ip -6 addr add fd00:300:4:0f40::4 dev mytunnel
ip -6 route add fd00:200:4::/48 dev mytunnel
