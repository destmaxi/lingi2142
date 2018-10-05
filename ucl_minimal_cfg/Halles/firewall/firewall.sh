#!/bin/bash

# Begin by flushing any default rules to create them from scratch:
ip6tables -F INPUT
ip6tables -F OUTPUT
ip6tables -F FORWARD
ip6tables -F

# We use a whitlisting policy so we only allow packets that match precise rules and we drop
# anything else, in INPUT/FORWARD/OUTPUT (see our report for more details about whitelisting)
ip6tables -P OUTPUT DROP
ip6tables -P INPUT DROP
ip6tables -P FORWARD DROP


# This router is a 'border router': there is a BGP session running on the interface $interface.
# We block hop limit exceeded towards outside network (rule against topology discovery with traceroute)
ip6tables -A OUTPUT  -o belnetb -p icmpv6 --icmpv6-type time-exceeded -j DROP
ip6tables -A FORWARD -o belnetb -p icmpv6 --icmpv6-type time-exceeded -j DROP

# Allow packets coming from related and established connections
ip6tables -A OUTPUT  -m state --state ESTABLISHED,RELATED -j ACCEPT
ip6tables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
ip6tables -A INPUT   -m state --state ESTABLISHED,RELATED -j ACCEPT


# Border router: block incomming packets that have a source ip from our network (spoofed source ip).
ip6tables -A FORWARD -i belnetb -s fd00:300:4::/50 -j DROP
ip6tables -A FORWARD -i belnetb -s fd00:200:4::/50 -j DROP
ip6tables -A INPUT   -i belnetb -s fd00:300:4::/50 -j DROP
ip6tables -A INPUT   -i belnetb -s fd00:200:4::/50 -j DROP

# Allow bgp on this border router on the interface where bgp should be enabled
ip6tables -A OUTPUT -o belnetb -p tcp -j ACCEPT --dport 179
ip6tables -A INPUT  -i belnetb -p tcp -j ACCEPT --dport 179

# Block ospf (in both direction) on interface $interface as we should not receive such
# packet from internet and it permits to avoid by error to send or ospf packet to the internet.
ip6tables -A INPUT   -i belnetb -p 89 -j DROP
ip6tables -A FORWARD -i belnetb -p 89 -j DROP
ip6tables -A FORWARD -o belnetb -p 89 -j DROP
ip6tables -A OUTPUT  -o belnetb -p 89 -j DROP
