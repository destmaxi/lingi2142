ip addr add dev ADM1-eth0 fd00:300:4:0a20::1/64
ip addr add dev ADM1-eth0 fd00:200:4:0a20::1/64

ip -6 route add ::/0 via fd00:300:4:0a10::
