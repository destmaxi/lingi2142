#!/bin/bash

apt-get -y -qq --force-yes update
#apt-get -y -qq --force-yes install build-essential checkinstall
#if !which cmake; then
#	wget http://www.cmake.org/files/v3.2/cmake-3.2.2.tar.gz
#	tar xf cmake-3.2.2.tar.gz
#	cd cmake-3.2.2
#	./configure
#	make
#	checkinstall -y
#	cd ..
#fi
#apt-get -y -qq --force-yes update

apt-get -y -qq --force-yes install git bash vim-nox tcpdump nano bird6 quagga inotify-tools iperf bind9 radvd snmp snmpd
apt-get -y -qq --force-yes install python python3 python-pip python3-pip 

pip install pysnmp
# dependencies for puppet
# apt-get -y -qq --force-yes install ruby ruby-dev libboost-all-dev gettext curl libcurl4-openssl-dev libyaml-cpp-dev
apt-get -y -qq --force-yes install puppet # TODO Get more recent version of puppet
#gem install puppet -f

apt-get -y -qq --force-yes install nmap

update-rc.d quagga disable &> /dev/null || true
update-rc.d bird disable &> /dev/null || true
update-rc.d bird6 disable &> /dev/null || true
update-rc.d snmpd disable $> /dev/null || true

service quagga stop
service bird stop
service bird6 stop
service snmpd stop

(cd /sbin && ln -s /usr/lib/quagga/* .)

su vagrant -c 'cd && git clone https://github.com/destmaxi/lingi2142.git'
