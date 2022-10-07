FROM avijit1979/hadoop_3.3.1
LABEL maintainer="Avijit GuhaBiswas <guhabiswas.avijit@gmail.com>"
LABEL name="admin/hbase-jdk8"

USER root

RUN useradd -s /bin/bash -d /home/hive -m -G hadoop hbase
RUN echo 'hbase ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
RUN echo "hbase:hbase" | chpasswd

WORKDIR /opt

ENV HBASE_VERSION=${HBASE_VERSION:-2.5.0}
RUN curl -k -L https://dlcdn.apache.org/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz -s -o - | tar -xzf -
RUN mv hbase-${HBASE_VERSION} hbase

ENV PATH /opt/hadoop/bin:/opt/hadoop/sbin:$PATH
ENV HBASE_HOME /opt/hbase
ENV PATH $HBASE_HOME/bin:$PATH

	
ADD conf/hbase-site.xml $HBASE_HOME/conf
WORKDIR $HBASE_HOME/bin
ADD startup.sh startup.sh
RUN chmod a+x startup.sh

RUN chown -R hbase:hadoop /opt/hbase
USER hbase
CMD ["./startup.sh"]