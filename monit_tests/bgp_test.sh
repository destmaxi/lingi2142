#!/bin/bash

DATE=`date '+%Y-%m-%d %H:%M:%S'`


echo "Checking BGP status on boarder routers [$DATE]"

sudo ip netns exec PYTH /home/vagrant/lingi2142/ucl_minimal_cfg/PYTH/script/check_BGP.sh PYTH

if [ $? -ne 1 ]
then
        echo "BGP ERROR : session not established on PYTH"
else
	echo "BGP session established on PYTH"
fi

sudo ip netns exec HALL /home/vagrant/lingi2142/ucl_minimal_cfg/HALL/script/check_BGP.sh HALL

if [ $? -ne 1 ]
then
        echo "BGP ERROR : session not established on HALL"
else
	echo "BGP session established on HALL"
fi

