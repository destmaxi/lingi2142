ip addr add dev fd00:300:4:0b30::1/64
ip addr add dev fd00:200:4:0b30::1/64

ip -6 route add ::/0 via fd00:300:4:0b30::
