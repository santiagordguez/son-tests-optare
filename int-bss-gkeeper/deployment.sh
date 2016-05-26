#!/bin/bash
#DEPLOYMENT
export DOCKER_HOST="tcp://sp.int2.sonata-nfv.eu:2375"

# -- run catalogue/repositories and gatekeeper containers
docker-compose -f scripts/docker-compose.yml down    
docker-compose -f scripts/docker-compose.yml up -d
sleep 10
docker-compose  -f int-bss-gkeeper/scripts/docker-compose.yml run --rm son-gtksrv bundle exec rake db:migrate
sleep 10

# -- insert NSD/VNFD
chmod +x *.sh
int-bss-gkeeper/scripts/postCatalogueSampleDescriptors.sh
int-bss-gkeeper/scripts/postGatekeeperSampleRequest.sh

# -- BSS
if ! [[ "$(docker inspect -f {{.State.Running}} intbssgkeeper_son-bss 2> /dev/null)" == "" ]]; then docker rm -fv intbssgkeeper_son-bss ; fi
docker run -d --name intbssgkeeper_son-bss -p 25001:1337 -p 25002:1338 -v "$(pwd)/reports:/usr/local/yeoman/SonataBSS/E2E_tests/reports" -it son-yo-gen-bss
docker exec -t intbssgkeeper_son-bss sudo chown yeoman:yeoman /usr/local/yeoman/SonataBSS/E2E_tests/reports
export DOCKER_HOST="unix:///var/run/docker.sock"
