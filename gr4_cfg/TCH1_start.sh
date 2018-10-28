ip addr add dev STAFF1-eth0 fd00:300:4:0960::1/64
ip addr add dev STAFF1-eth0 fd00:200:4:0960::1/64

ip -6 route add ::/0 via fd00:300:4:0960::
