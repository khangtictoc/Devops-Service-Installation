#! /bin/bash

# Refer to: https://www.jenkins.io/doc/book/installing/linux/

sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade

# Install Java
sudo yum -y install java-11-openjdk
echo "#################### JAVA 11 INSTALLATION COMPLETED ##################"
java -version

sudo yum -y install jenkins
sudo systemctl daemon-reload

echo "Bootstrapping Jenkins service. Please wait ..."
sudo systemctl start jenkins

sudo systemctl stop firewalld

echo "!!! ACCESS JENKINS AT PORT 8080 !!!"
echo "YOUR INSTALLATION PASSWORD IS: $(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)"