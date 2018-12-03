all: config_log create_network

config_log:
	sudo ./util/create_configs.sh

create_network:
	sudo ./create_network.sh gr4_topo
	python3 util/start_ping.py &

connect:
	sudo ./connect_to.sh gr4_cfg/ $(filter-out $@,$(MAKECMDGOALS))

test:
	sudo python3 tests/main_tests.py $(filter-out $@,$(MAKECMDGOALS))

%:
	@:


clean:
	sudo ./cleanup.sh
