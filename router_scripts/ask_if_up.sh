#!/bin/sh

# $1 is router, $2 is ethernet interface

res=$(ip addr show $1-$2 | grep $1-$2 | awk '{print $9}')

if [ "$res" != "UP" ]
then
	exit 0
else
	exit 1
fi
