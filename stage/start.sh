#!/bin/bash

set -e

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export PATH=$ORACLE_HOME/bin:$PATH

sed -i -E "s/HOST = [^)]+/HOST = ${HOSTNAME}/g" ${ORACLE_HOME}/network/admin/listener.ora
sed -i -E "s/HOST = [^)]+/HOST = ${HOSTNAME}/g" ${ORACLE_HOME}/network/admin/tnsnames.ora
service oracle-xe start
lsnrctl status

echo "Oracle started successfully!"

# forever loop just to prevent Docker container to exit, when run as daemon
while true; do sleep 1000; done
