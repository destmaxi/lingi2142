#!/bin/bash

sudo ip netns exec PYTH /home/vagrant/lingi2142/ucl_minimal_cfg/PYTH/script/check_BGP.sh PYTH

if [ $? -ne 1 ]
then
        echo "BGP ERROR : session not established on PYTH"
fi

sudo ip netns exec HALL /home/vagrant/lingi2142/ucl_minimal_cfg/HALL/script/check_BGP.sh HALL

if [ $? -ne 1 ]
then
        echo "BGP ERROR : session not established on HALL"
fi

