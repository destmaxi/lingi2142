#!/bin/bash

# $1 is the interface we check

DATE=`date '+%Y-%m-%d %H:%M:%S'`

echo "Checking if PYTH-HALL link fails [$DATE]"

sudo ip netns exec HALL /home/vagrant/lingi2142/ucl_minimal_cfg/HALL/script/ask_if_up.sh HALL eth1

if [ $? -ne 1 ]
then
        echo "WARNING : eth1 on HALL is down, maybe link failure !"
else
	echo "eth1 on HALL is up"
fi

sudo ip netns exec PYTH /home/vagrant/lingi2142/ucl_minimal_cfg/PYTH/script/ask_if_up.sh PYTH eth0

if [ $? -ne 1 ]
then
	echo "WARNING : eth0 on PYTH is down, maybe link failure !"
else
	echo "eth0 on PYTH is up"
fi
