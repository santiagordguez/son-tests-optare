#!/bin/bash
docker exec -t -d son-bss grunt serve:integration_tests --suite=intBSS_GK

# -- get the remote reports
x=0
while [ "$x" -lt 100 -a ! -e $(pwd)/reports/htmlReport.html ]; do
        x=$((x+1))		
		docker cp son-bss:/usr/local/yeoman/SonataBSS/E2E_tests/reports/htmlReport.html .
        sleep 1		
done
docker cp son-bss:/usr/local/yeoman/SonataBSS/E2E_tests/reports .