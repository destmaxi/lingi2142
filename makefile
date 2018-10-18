all: config_log create_network

config_log:
	sudo ./config_log.sh

create_network:
	sudo ./create_network.sh gr4_topo

connect:
	sudo ./connect_to.sh gr4_cfg/ $(filter-out $@,$(MAKECMDGOALS))

%:
	@:


clean:
	sudo ./cleanup.sh
