#!/bin/bash

# -- insert NSD/VNFD
curl -H "Content-Type: application/json" -X POST --data-binary @int-service-instantiation/resources/VNFD_firewall.json http://chdocker:4002/catalogues/vnfs
curl -H "Content-Type: application/json" -X POST --data-binary @int-service-instantiation/resources/VNFD_iperf.json http://chdocker:4002/catalogues/vnfs
curl -H "Content-Type: application/json" -X POST --data-binary @int-service-instantiation/resources/VNFD_tcpdump.json http://chdocker:4002/catalogues/vnfs
curl -H "Content-Type: application/json" -X POST --data-binary @int-service-instantiation/resources/NSD.json http://chdocker:4002/catalogues/network-services