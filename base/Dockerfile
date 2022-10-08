FROM rtfpessoa/ubuntu-jdk8:2.0.40

ENV DEBIAN_FRONTEND noninteractive

USER root 
RUN apt-get update
RUN apt-get -qy dist-upgrade

RUN apt-get install -qy rsync curl openssh-server openssh-client vim nfs-common apt-transport-https locales krb5-user bash sudo

RUN mkdir -p /data/hdfs-nfs/

WORKDIR /opt

# Install Hadoop
RUN curl -L https://archive.apache.org/dist/hadoop/core/hadoop-3.3.1/hadoop-3.3.1.tar.gz -s -o - | tar -xzf -
RUN mv hadoop-3.3.1 hadoop
RUN mkdir -p /opt/hadoop/logs
# Setup
WORKDIR /opt/hadoop
RUN mkdir -p /hadoop/dfs/name
RUN mkdir -p /hadoop/dfs/data
RUN mkdir -p /opt/hadoop/temp
RUN mkdir -p /opt/hadoop/logs


RUN echo "\n export HDFS_NAMENODE_USER=hdfs \n" >> etc/hadoop/hadoop-env.sh &&\
    echo "\n export HDFS_DATANODE_USER=hdfs \n" >> etc/hadoop/hadoop-env.sh &&\
	echo "\n export HDFS_SECONDARYNAMENODE_USER=hdfs \n" >> etc/hadoop/hadoop-env.sh &&\
	echo "\n export JAVA_HOME=/usr/lib/jvm/java-8-oracle \n" >> etc/hadoop/hadoop-env.sh &&\
	echo "\n export HADOOP_HOME=/opt/hadoop \n" >> etc/hadoop/hadoop-env.sh 
	
# Configure ssh client
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

RUN echo "\nHost *\n" >> ~/.ssh/config && \
    echo "   AddKeysToAgent yes\n" >> ~/.ssh/config && \
    echo "   IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config

# Disable sshd authentication
RUN echo "root:root" | chpasswd
USER root
RUN groupadd hadoop
RUN useradd -s /bin/bash -d /home/hdfs -m -G hadoop hdfs
RUN useradd -s /bin/bash -d /home/admin -m -G hadoop admin
RUN echo 'hdfs ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
RUN echo 'admin ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
RUN echo "hdfs:hdfs" | chpasswd
RUN echo "admin:admin" | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
COPY core-site.xml etc/hadoop/core-site.xml
COPY hdfs-site.xml etc/hadoop/hdfs-site.xml
COPY yarn-site.xml etc/hadoop/yarn-site.xml
COPY log4j.properties etc/hadoop/log4j.properties
COPY mapred-site.xml etc/hadoop/mapred-site.xml

RUN chown -R hdfs:hadoop /opt/hadoop
RUN chown -R hdfs:hadoop /hadoop/dfs






