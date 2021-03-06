#!/bin/bash

puppet apply --verbose --parser future --hiera_config=/etc/puppet/hiera.yaml /etc/puppet/site.pp --modulepath=/puppetmodules

ip -6 rule add from fd00:300:4::/48 to fd00:200:4::/48 pref 1000 table main
ip -6 rule add from fd00:300:4::/48 to fd00:300:4::/48 pref 1000 table main
ip -6 rule add from fd00:300:4::/48 pref 2000 table 10

ip -6 tunnel add mytun mode ip6ip6 remote fd00:300:4:0f00::4 local fd00:300:4:f00::2
ip -6 link set mytun up
ip -6 addr add fd00:300:4:0f20::2 dev mytun
ip -6 addr add fd00:200:4:0f20::2 dev mytun
ip -6 route add fd00:300::/48 dev mytun

ip -6 route add ::/0 dev mytun table 10
