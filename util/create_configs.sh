#!/bin/bash

routers="HALL PYTH MICH SH1C CARN STEV"
boot="#!/bin/bash\n\nsysctl -p"
start="#!/bin/bash\n\npuppet apply --verbose --parser future --hiera_config=/etc/puppet/hiera.yaml /etc/puppet/site.pp --modulepath=/puppetmodules"


for r in $routers; do
  cp /etc/protocols gr4_cfg/$r/protocols
done
