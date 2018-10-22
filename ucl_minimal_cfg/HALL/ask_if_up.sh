#!/bin/sh

# $1 is ethernet interface

value=`cat /sys/class/net/$1/operstate`

if [ "$value" = "up" ];
then
        exit 1
else
        exit 0
fi
