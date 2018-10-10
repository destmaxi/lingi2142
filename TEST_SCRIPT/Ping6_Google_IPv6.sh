#!/bin/sh
 
# -q quiet
# -c nb of pings to perform
# 2001:4860:4802:34::a is one of google.com server
 
ping6 -q -c5 2001:4860:4802:34::a > /dev/null
 
if [ $? -eq 0 ]
then
        echo "ok"
fi


