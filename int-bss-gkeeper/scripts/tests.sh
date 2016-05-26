#!/bin/bash
export DOCKER_HOST="tcp://sp.int2.sonata-nfv.eu:2375"
docker exec -t -d intbssgkeeper_son-bss grunt serve:integration_tests --suite=intBSS_GK

# -- get remote reports
cd /var/lib/jenkins/jobs/int-bss-gkeeper/workspace/int-bss-gkeeper/reports/
x=0
while [ "$x" -lt 100 -a ! -e .htmlReport.html ]; do
        x=$((x+1))		
        sleep 1
done

export DOCKER_HOST="unix:///var/run/docker.sock"

