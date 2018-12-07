#!/bin/bash

for a in $(ps -ax |grep lingi2142 |grep -v 'makefile\|kill_all_processes\|cleanup\|grep' | awk '{ print $1; }')
do
if ps -p $a > /dev/null; then sudo kill $a; fi
done
