#!/bin/bash

echo "Waiting 40 sec for network creation"

sleep 40 #time for network creation

sudo ip netns exec PYTH /home/vagrant/lingi2142/gr4_cfg/PYTH/script/check_OSPF.sh

sudo ip netns exec HALL /home/vagrant/lingi2142/gr4_cfg/HALL/script/check_OSPF.sh

sudo ip netns exec STEV /home/vagrant/lingi2142/gr4_cfg/STEV/script/check_OSPF.sh

sudo ip netns exec CARN /home/vagrant/lingi2142/gr4_cfg/CARN/script/check_OSPF.sh

sudo ip netns exec SH1C /home/vagrant/lingi2142/gr4_cfg/SH1C/script/check_OSPF.sh

sudo ip netns exec MICH /home/vagrant/lingi2142/gr4_cfg/MICH/script/check_OSPF.sh

echo "OSPF script terminated"
