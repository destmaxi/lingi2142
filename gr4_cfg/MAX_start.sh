ip addr add dev MAX-eth0 fd00:300:4:0b30::2/64
ip addr add dev MAX-eth0 fd00:200:4:0b30::2/64

ip -6 route add ::/0 via fd00:300:4:0b30::
