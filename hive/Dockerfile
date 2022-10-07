FROM avijit1979/hadoop_3.3.1
LABEL maintainer="Avijit GuhaBiswas <guhabiswas.avijit@gmail.com>"
LABEL name="admin/hive-jdk8"

USER root

RUN useradd -s /bin/bash -d /home/hive -m -G hadoop hive
RUN echo 'hive ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
RUN echo "hive:hive" | chpasswd

WORKDIR /opt

ENV HIVE_VERSION=${HIVE_VERSION:-3.1.2}
RUN curl -L https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz | tar -xzf -
RUN mv apache-hive-$HIVE_VERSION-bin hive
RUN mkdir -p /opt/hive/logs
RUN mkdir -p /opt/hive/bin

ENV HADOOP_HOME /opt/hadoop
ENV PATH /opt/hadoop/bin:/opt/hadoop/sbin:$PATH
ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH

	
ADD conf/hive-site.xml $HIVE_HOME/conf
ADD conf/hive-env.sh $HIVE_HOME/conf
ADD conf/hive-log4j2.properties $HIVE_HOME/conf
ADD conf/beeline-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-exec-log4j2.properties $HIVE_HOME/conf
ADD lib/mysql-connector-java-8.0.28.jar $HIVE_HOME/lib/mysql-connector-java-8.0.28.jar


WORKDIR /opt/hive/bin
ADD startup.sh startup.sh
RUN chmod a+x startup.sh
RUN chown -R hive:hadoop /opt/hive
USER hive
CMD ["./startup.sh"]