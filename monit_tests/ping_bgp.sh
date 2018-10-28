#!/bin/bash

sudo ip netns exec PYTH /home/vagrant/lingi2142/gr4_cfg/PYTH/bgp_script/ping_BGP.sh

sudo ip netns exec HALL /home/vagrant/lingi2142/gr4_cfg/HALL/bgp_script/ping_BGP.sh

echo "BGP ping script terminated"