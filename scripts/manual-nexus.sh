#! /bin/bash

# Refer to https://help.sonatype.com/repomanager3/installation-and-upgrades/installation-methods
wget https://download.sonatype.com/nexus/3/nexus-3.56.0-01-unix.tar.gz
tar xvzf nexus-3.56.0-01-unix.tar.gz

sudo chmod 777 nexus-3.56.0-01/bin/*

sudo yum install java-1.8.0-openjdk -y
echo "#################### JAVA 8 INSTALLATION COMPLETED ##################"
java -version

# echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.372.b07-1.el7_9.x86_64" >> ~/.bashrc 
# source ~/.bashrc
# echo $JAVA_HOME


./nexus-3.56.0-01/bin/nexus start &

sudo systemctl stop firewalld

echo "!!! ACCESS NEXUS AT PORT 8081 !!!"