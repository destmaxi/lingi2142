#!/bin/bash

ip addr add dev DNS1-eth0 fd00:300:4:e10::1/64
ip -6 route add ::/0 via fd00:300:4:e10::
named
