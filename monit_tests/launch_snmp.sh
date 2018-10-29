#!/bin/bash

DATE=`date '+%Y-%m-%d %H:%M:%S'`

echo "########################"
echo "SNMP script run at $DATE"
echo "########################"

sudo ip netns exec MONI python /home/vagrant/lingi2142/gr4_cfg/MONI/snmp_requests.py
