#!/bin/bash

# $1 : name of the routeur

DATE=`date '+%Y-%m-%d %H:%M:%S'`

echo "Output of BGP check script launched on $DATE"

echo "################################################"

res=$(birdc -s /tmp/$1_bird6.ctl "show protocol all bgp_provider" | sed -n 3p | awk {'print $6'})

if [ "$res" != "Established" ];
then
        exit 0
else
        exit 1
fi
