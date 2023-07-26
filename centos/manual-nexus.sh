#! /bin/bash

# Refer to https://help.sonatype.com/repomanager3/installation-and-upgrades/installation-methods
wget https://download.sonatype.com/nexus/3/nexus-3.56.0-01-unix.tar.gz
tar xvzf nexus-3.56.0-01-unix.tar.gz

sudo chmod 777 nexus-3.56.0-01/bin/*

sudo apt install java-1.8.0-openjdk -y
echo "#################### JAVA 8 INSTALLATION COMPLETED ##################"
java -version


sudo useradd nexus
sudo passwd nexus <<EOF 
nexus
nexus
EOF

sudo cp -r nexus-3.56.0-01 /home/nexus
sudo chown -R nexus:nexus /home/nexus/nexus-3.56.0-01

sudo -i <<EOF2
cat <<EOF> /etc/systemd/system/nexus.service

[Unit]
Description=nexus service
After=network.target
 
[Service]
Type=forking
ExecStart=/home/nexus/nexus-3.56.0-01/bin/nexus start 
ExecStop=/home/nexus/nexus-3.56.0-01/bin/nexus stop 
User=nexus
#If there are spaces, I would strings within quotes like above
Restart=on-failure
 
[Install]
WantedBy=multi-user.target

EOF
EOF2

sudo systemctl daemon-reload
sudo systemctl start nexus

sudo systemctl stop firewalld

echo "!!! ACCESS NEXUS AT PORT 8081 !!!"