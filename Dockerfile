# Use the CentOS 7 base image
FROM centos:7

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk \
    CATALINA_HOME=/opt/tomcat \
    PATH=$CATALINA_HOME/bin:$PATH

# Install Java 8 and necessary packages
RUN yum -y update && \
    yum -y install java-1.8.0-openjdk-devel wget && \
    yum clean all

# Install the unzip package
RUN yum -y install unzip

# Download and extract Tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.91/bin/apache-tomcat-8.5.91.zip && \
    unzip apache-tomcat-8.5.91.zip -d /opt && \
    rm apache-tomcat-8.5.91.zip && \
    mv /opt/apache-tomcat-8.5.91 $CATALINA_HOME

# Set executable permissions for catalina.sh
RUN chmod +x $CATALINA_HOME/bin/catalina.sh

# Expose the default Tomcat port
EXPOSE 8090

# Set the command to start Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
