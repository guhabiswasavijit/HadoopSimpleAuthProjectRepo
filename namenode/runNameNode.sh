#!/bin/bash

namedir=`echo $HDFS_CONF_dfs_namenode_name_dir | perl -pe 's#file://##'`
if [ ! -d $namedir ]; then
  echo "Namenode name directory not found: $namedir"
  exit 2
fi

if [ -z "$CLUSTER_NAME" ]; then
  echo "Cluster name not specified"
  exit 2
fi


if [ "`ls -A $namedir`" == "" ]; then
  echo "Formatting namenode name directory: $namedir"
   echo 'Y' | hdfs namenode -format $CLUSTER_NAME
fi

sudo service ssh start \
  && hdfs namenode \
  && hdfs secondarynamenode\
  && hdfs dfs -mkdir -p /user/hdfs\
  && hdfs dfs -mkdir -p /user/admin\
  && hdfs dfs -chown -R admin:hadoop /user/admin