all: config_log create_network

config_log:
	sudo ./config_log.sh

create_network:
	sudo ./create_network.sh ucl_topo

connect:
	sudo ./connect_to.sh ucl_minimal_cfg/ $(filter-out $@,$(MAKECMDGOALS))

%:
	@:


clean:
	sudo ./cleanup.sh
