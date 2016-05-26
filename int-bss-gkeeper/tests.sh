#!/bin/bash
docker exec -t -d son-bss grunt serve:integration_tests --suite=intBSS_GK

# -- get the remote reports
cd /var/lib/jenkins/jobs/int-bss-gkeeper/workspace/int-bss-gkeeper/reports/
x=0
while [ "$x" -lt 100 -a ! -e .htmlReport.html ]; do
        x=$((x+1))		
        sleep 1
done
