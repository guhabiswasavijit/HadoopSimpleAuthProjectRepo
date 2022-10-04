#!/bin/bash
hdfs dfs -mkdir -p /user/hive/warehouse \
&& sudo service ssh start\
&& hiveserver2