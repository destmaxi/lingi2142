#!/bin/bash

# $1 is the interface we check

DATE=`date '+%Y-%m-%d %H:%M:%S'`

echo "Setting HALL-eth1 down"

sudo ip netns exec HALL ip link set HALL-eth1 down

echo "Waiting stabilization"

sleep 30

echo "Checking if PYTH-HALL link fails [$DATE]"

sudo ip netns exec HALL /home/vagrant/lingi2142/gr4_cfg/HALL/bgp_script/ask_if_up.sh HALL eth1

if [ $? -ne 1 ]
then
        echo "WARNING : eth1 on HALL is down, maybe link failure !"
else
	echo "eth1 on HALL is up"
fi



echo "Setting HALL-eth1 up"

sudo ip netns exec HALL /home/vagrant/lingi2142/gr4_cfg/HALL/static_routes/static_routes.sh >/dev/null 2>&1

echo "Waiting stabilization"

sleep 30

echo "Checking if PYTH-HALL link fails [$DATE]"

sudo ip netns exec HALL /home/vagrant/lingi2142/gr4_cfg/HALL/bgp_script/ask_if_up.sh HALL eth1

if [ $? -ne 1 ]
then
        echo "WARNING : eth1 on HALL is down, maybe link failure !"
else
        echo "eth1 on HALL is up"
fi





echo "Setting PYTH-eth0 down"

sudo ip netns exec PYTH ip link set PYTH-eth0 down

echo "Waiting stabilization"

sleep 30

echo "Checking if PYTH-HALL link fails [$DATE]"

sudo ip netns exec PYTH /home/vagrant/lingi2142/gr4_cfg/PYTH/bgp_script/ask_if_up.sh PYTH eth0

if [ $? -ne 1 ]
then
        echo "WARNING : eth0 on PYTH is down, maybe link failure !"
else
        echo "eth0 on PYTH is up"
fi



echo "Setting PYTH-eth0 up"

sudo ip netns exec PYTH /home/vagrant/lingi2142/gr4_cfg/PYTH/static_routes/static_routes.sh >/dev/null 2>&1

echo "Waiting stabilization"

sleep 30

echo "Checking if PYTH-HALL link fails [$DATE]"

sudo ip netns exec PYTH /home/vagrant/lingi2142/gr4_cfg/PYTH/bgp_script/ask_if_up.sh PYTH eth0

if [ $? -ne 1 ]
then
        echo "WARNING : eth0 on PYTH is down, maybe link failure !"
else
        echo "eth0 on PYTH is up"
fi

echo "Check link failure script terminated"
