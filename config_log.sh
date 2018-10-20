#!/bin/bash

routers="HALL PYTH MICH SH1C CARN STEV"

for r in $routers; do
  mkdir -p gr4_cfg/r/log
  sudo echo > gr4_cfg/r/log/bird_log
  sudo echo > gr4_cfg/r/log/nmap.result
  cp /etc/protocols gr4_cfg/r/protocols
done
