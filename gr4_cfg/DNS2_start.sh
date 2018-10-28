#!/bin/bash

ip addr add dev DNS2-eth0 fd00:300:4:e31::2/64
ip -6 route add ::/0 via fd00:300:4:e31::
named
