#!/bin/bash
sudo service ssh start\
&& hadoop dfsadmin -safemode leave\
&& source hbase-env.sh\
&& hbase-daemon.sh start master\
&& hbase thrift start -p 9090 --infoport 9094\
&& hbase rest start -p 8082 --infoport 8081

