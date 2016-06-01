#!/bin/bash
#DEPLOYMENT

# -- run catalogue/repositories and gatekeeper containers
docker-compose -f int-bss-gkeeper/scripts/docker-compose.yml down    
docker-compose -f int-bss-gkeeper/scripts/docker-compose.yml up -d
sleep 10
docker-compose  -f int-bss-gkeeper/scripts/docker-compose.yml run --rm son-gtksrv bundle exec rake db:migrate
sleep 10

# -- insert NSD/VNFD
int-bss-gkeeper/scripts/postCatalogueSampleDescriptors.sh
int-bss-gkeeper/scripts/postGatekeeperSampleRequest.sh
sleep 5
# -- BSS
if ! [[ "$(docker inspect -f {{.State.Running}} son-bss 2> /dev/null)" == "" ]]; then docker rm -fv son-bss ; fi
#docker run -d --name son-bss -p 25001:1337 -p 25002:1338 -v "$(pwd)/reports:/usr/local/yeoman/SonataBSS/E2E_tests/reports" -it son-yo-gen-bss
docker run -d --name son-bss -p 25001:1337 -p 25002:1338 son-yo-gen-bss grunt serve:development --gkApiUrl=http://chdocker.optare.loc:25002/mock
#docker exec -t son-bss sudo chown yeoman:yeoman /usr/local/yeoman/SonataBSS/E2E_tests/reports