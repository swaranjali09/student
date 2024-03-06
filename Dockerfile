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
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.86/bin/apache-tomcat-9.0.86.zip && \
    unzip apache-tomcat-9.0.86.zip -d /opt && \
    rm -f apache-tomcat-9.0.86.zip && \
    mv /opt/apache-tomcat-9.0.86 $CATALINA_HOME
WORKDIR /opt/tomcat
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/student.war webapps/
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/mysql-connector.jar lib/

# Set executable permissions for catalina.sh
RUN chmod +x $CATALINA_HOME/bin/catalina.sh

# Expose the default Tomcat port
EXPOSE 8081

# Set the command to start Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
