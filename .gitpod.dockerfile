FROM gitpod/workspace-mysql



USER root
# Install custom tools, runtime, etc.


RUN apt-get update && apt-get install -y \
        git-flow \
	graphviz \
	&& apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*
	
RUN apt-get update && \
	apt-get install -y openjdk-8-jdk && \
	apt-get install -y ant && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;
	
	RUN apt-get update && \
	apt-get install -y ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;
	
	ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
        RUN export JAVA_HOME	
	
	
	
	
RUN wget https://archive.cloudera.com/cdh5/ubuntu/xenial/amd64/cdh/archive.key
RUN sudo apt-key add archive.key
RUN sudo echo ”deb [arch=amd64] https://archive.cloudera.com/cdh5/ubuntu/xenial/amd64/cdh xenial-cdh5 contrib” >> /etc/apt/sources.list
	
RUN sudo apt-get install cloudera-manager-agent cloudera-manager-daemons
RUN sudo systemctl start cloudera-scm-agent
#RUN sleep 90
RUN sudo apt-get install avro-tools bigtop-jsvc bigtop-utils flume-ng hadoop-hdfs-fuse hadoop-hdfs-nfs3 hadoop-httpfs hadoop-kms hbase hbase-solr hive-hbase hive-webhcat hue impala impala-shell kafka kite keytrustee-keyprovider kudu oozie parquet parquet-format pig search sentry sentry-hdfs-plugin solr solr-crunch solr-mapreduce spark-core spark-python sqoop zookeeper
	
	
#RUN wget -qO - https://packages.confluent.io/deb/4.0/archive.key | sudo apt-key add -
#RUN sudo add-apt-repository "deb [arch=amd64] https://packages.confluent.io/deb/4.0 stable main"
#RUN sudo apt-get update && sudo apt-get install -y confluent-platform-oss-2.11
	

USER gitpod
# Apply user-specific settings
	RUN bash -c "npm install -g generator-jhipster \
	&& npm install -g @angular/cli" 
	
 	

# Give back control
USER root
