#!/bin/bash

for a in $(ps -ax |grep lingi2142 | awk '{ print $1; }')
do
 sudo kill $a 
done 
