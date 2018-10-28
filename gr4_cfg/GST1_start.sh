ip addr add dev GUEST1-eth0 fd00:300:4:0c60::1/64
ip addr add dev GUEST1-eth0 fd00:200:4:0c60::1/64

ip -6 route add ::/0 via fd00:300:4:0c60::
