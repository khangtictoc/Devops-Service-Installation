#! /bin/bash
# Download
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
echo "[DONE] - INSTALL JENKINS"

# Install Java
sudo apt install openjdk-11-jdk-headless -y
echo "[DONE] - INSTALL JAVA 11"
java -version

echo "+++++++ SELECT JAVA VERSION TO INSTALL (JAVA 11 REQUIRED) +++++++"
sudo update-alternatives --config java

# Start jenkins service
sudo systemctl enable jenkins
sudo systemctl start jenkins
echo "[DONE] - START JENKINS"

echo "!!! ACCESS JENKINS AT PORT 8080 !!!"
echo "YOUR INSTALLATION PASSWORD IS: $(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)"