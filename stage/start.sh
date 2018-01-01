#!/bin/bash

set -e

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export PATH=$ORACLE_HOME/bin:$PATH

sed -i -E "s/HOST = [^)]+/HOST = ${HOSTNAME}/g" ${ORACLE_HOME}/network/admin/listener.ora
sed -i -E "s/HOST = [^)]+/HOST = ${HOSTNAME}/g" ${ORACLE_HOME}/network/admin/tnsnames.ora
service oracle-xe start
if [ $? -ne 0 ]; then
  "echo err: oracle-xe service didn't start"
  "echo remember start container like:"
  "echo docker run --rm -p 1521:1521 --shm-size=1g --memory=1g --memory-swap=2g <container> ./start.sh"
  exit 1
else
  echo "Oracle started successfully!"
fi

lsnrctl status

# forever loop just to prevent Docker container to exit, when run as daemon
while true; do sleep 1000; done
