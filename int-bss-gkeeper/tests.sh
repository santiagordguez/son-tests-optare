#!/bin/bash
#docker exec -t -d son-bss grunt serve:integration_tests --suite=intBSS_GK
docker run -d --name son-bss -p 25001:1337 -p 25002:1338 --log-driver=gelf --log-opt gelf-address=udp://172.20.49.181:12900 son-yo-gen-bss grunt serve:integration_tests --gkApiUrl=http://172.20.49.181:25002/mock --suite=unitTests --debug
# -- get the remote reports
x=0
while [ "$x" -lt 100 -a ! -e $(pwd)/reports/htmlReport.html ]; do
        x=$((x+1))		
		docker cp son-bss:/usr/local/yeoman/SonataBSS/E2E_tests/reports/htmlReport.html .
        sleep 1		
done
docker cp son-bss:/usr/local/yeoman/SonataBSS/E2E_tests/reports .