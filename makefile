all: create_network

create_network:
	sudo ./create_network.sh ucl_topo

connect:
	sudo ./connect_to.sh ucl_minimal_cfg/ $(filter-out $@,$(MAKECMDGOALS))

%:
	@:


clean:
	sudo ./cleanup.sh
