#!/bin/bash
docker exec -t -d son-bss grunt serve:integration_tests --suite=intBSS_GK

# -- get the remote reports
x=0
while [ "$x" -lt 100 -a ! -e int-bss-gkeeper/reports/htmlReport.html ]; do
        x=$((x+1))		
        sleep 1
done
