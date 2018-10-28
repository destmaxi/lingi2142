#!/bin/sh

######################################################################
#              Script to do the redirection                          #
######################################################################
#              I've commented the id1                                #
######################################################################

#return 1 if the link is up and 0 is not
is_hall_link_pyth_ok () {
  ping6 -q -c1 fd00:300:4:f24::4 > /dev/null
  if [ $? -ne 0 ]
  then
          echo "ERREUR PING From 2 to fd00:300:f24::4"
          return 0
  fi
  ping6 -q -c1 fd00:300:4:f24::2 > /dev/null
  if [ $? -ne 0 ]
  then
          echo "ERREUR PING From 2 to fd00:300:f24::2"
          return 0
  fi
  return 1
}

#Delete all the policy routing rules
del_all_rules () {
  ip -6 rule del priority 1000
  ip -6 rule del priority 1000
  ip -6 rule del priority 2000
  ip -6 rule del priority 2000
}

wait=-1 #variable used to make the script wait for the first execution to wait the network setup
table=0 # if table=1 the network forward paquet like link down, table=0 the network forward paquet like link up

while [ true ]
do

if [ $wait -eq -1 ];then
  echo "wait 60sec"
  sleep 60 #We wait that the network setup
  wait=0
fi

sleep 5 #we wait 5sec during each loop to try not to overuse the network power


is_hall_link_pyth_ok
content=$?
if [ ${content} -eq 1 ] && [ $table -eq 0 ];then
  echo "Init HAll"
  del_all_rules
  ip -6 rule add from all to fd00:200:4::/48 priority 1000 table main
  ip -6 rule add from all to fd00:300:4::/48 priority 1000 table main
  ip -6 rule add from fd00:300:4::/48 to all priority 2000 table 10

  a="$(ip -6 route show | grep fd00:300:4:f00::4 | cut -c23-60 | awk -F dev '{print $1}')"
  ip -6 route del default table 10
  ip -6 route add default via ${a} dev HALL-eth1 table 10

  table=1
fi
if [ ${content} -eq 1 ];then
  into_table_10="$(ip -6 route ls table 10 | cut -c13-60 | awk -F dev '{print $1}')"
  into_routing_table="$(ip -6 route show | grep fd00:300:4:f00::4 | cut -c23-60 | awk -F dev '{print $1}')"
  if [ ${into_routing_table} != ${into_table_10} ];then
    ip -6 route del default table 10
    ip -6 route add default via ${into_routing_table} dev HALL-eth1 table 10
  fi
fi
if [ ${content} -eq 0 ] && [ $table -eq 1 ];then
  echo "link down"

  a="$(ip -6 route show | grep fd00:300:4:f00::5 | cut -c23-60 | awk -F dev '{print $1}')"

  ip -6 route del default dev HALL-eth1 table 10
  ip -6 route add default via ${a} dev HALL-eth0 table 10

  table=0

fi


done
