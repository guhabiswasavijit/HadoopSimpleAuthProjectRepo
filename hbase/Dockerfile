FROM avijit1979/hadoop_3.3.1
LABEL maintainer="Avijit GuhaBiswas <guhabiswas.avijit@gmail.com>"
LABEL name="admin/hbase-jdk8"

USER root

RUN useradd -s /bin/bash -d /home/hbase -m -G hadoop hbase
RUN echo 'hbase ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
RUN echo "hbase:hbase" | chpasswd

WORKDIR /opt

ENV HBASE_VERSION=${HBASE_VERSION:-2.5.0}
RUN curl -k -L https://dlcdn.apache.org/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz -s -o - | tar -xzf -
RUN mv hbase-${HBASE_VERSION} hbase

ENV PATH /opt/hadoop/bin:/opt/hadoop/sbin:$PATH
ENV HBASE_HOME /opt/hbase
ENV PATH $HBASE_HOME/bin:$PATH
RUN mkdir -p /opt/hbase/zookeeper/data
RUN mkdir -p /opt/hbase/tmp
RUN mkdir -p $HBASE_HOME/pids
RUN mkdir -p $HBASE_HOME/logs
	
ADD conf/hbase-site.xml $HBASE_HOME/conf
ADD conf/log4j2.properties $HBASE_HOME/conf
ADD conf/regionservers $HBASE_HOME/conf
ADD conf/backup-masters $HBASE_HOME/conf

WORKDIR $HBASE_HOME/bin
ADD startup.sh startup.sh
RUN chmod a+x startup.sh
ADD conf/hbase-env.sh hbase-env.sh
RUN chmod a+x hbase-env.sh
ADD conf/hbase-daemon.sh hbase-daemon.sh
RUN chmod a+x hbase-daemon.sh
RUN chown -R hbase:hadoop /opt/hbase
USER hbase
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

RUN echo "\nHost *\n" >> ~/.ssh/config && \
    echo "   AddKeysToAgent yes\n" >> ~/.ssh/config && \
    echo "   IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/known_hosts
CMD ["./startup.sh"]