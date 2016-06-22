#!/bin/bash
docker rm -fv son-bss

# -- Launch service instantiation
docker run -d --name son-bss -p 25001:1337 -p 25002:1338 --log-driver=gelf --log-opt gelf-address=udp://172.20.49.181:12900 son-yo-gen-bss grunt serve:integration_tests --gkApiUrl=http://chdocker:32001 --suite=service_Instantiation --debug
#docker exec -t -d son-bss grunt protractor_webdriver protractor:run --suite=unit

sleep 5

# -- Retrieve information
int-service-instantiation/scripts/getModulesInfoFromGraylog.sh

sleep 5

# -- Check Request Status
docker run -d --name son-bss -p 25001:1337 -p 25002:1338 --log-driver=gelf --log-opt gelf-address=udp://172.20.49.181:12900 son-yo-gen-bss grunt serve:integration_tests --gkApiUrl=http://chdocker:32001 --suite=ready_Request_Validation --debug

# -- get the remote reports
x=0
docker cp son-bss:/usr/local/yeoman/SonataBSS/E2E_tests/reports .
while [ "$x" -lt 100 -a ! -e $(pwd)/reports/ready_Request_Validation.html ]; do
        x=$((x+1))		
        sleep 1
		docker cp son-bss:/usr/local/yeoman/SonataBSS/E2E_tests/reports .
done