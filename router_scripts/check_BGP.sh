#!/bin/bash

# $1 : name of the routeur

res=$(birdc -s /tmp/$1_bird6.ctl "show protocol all bgp_provider" | sed -n 3p | awk {'print $6'})

if [ "$res" != "Established" ];
then
        exit 0
else
        exit 1
fi
