all: create_network

create_network:
	sudo ./create_network ucl_topo

clean:
	sudo ./cleanup.sh
