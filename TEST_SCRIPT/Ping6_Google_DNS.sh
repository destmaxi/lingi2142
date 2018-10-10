#!/bin/sh
 
# -q quiet
# -c nb of pings to perform


ping6 -q -c5 google.com > /dev/null

if [ $? -eq 0 ]
then
        echo "ok with google.com"
fi


