#! /bin/bash

# Refer to https://computingforgeeks.com/install-sonarqube-code-review-centos/?expand_article=1

### CONVENTION

echo "########## CONVENTION ##########"
echo "Password for user 'sonar' is 'sonar'"
echo "Password for user 'postgres' is 'postgres'"
echo "--------------------------------"
echo
echo

### PRE-SET UP

sudo yum install vim wget curl unzip -y

sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

sudo tee -a /etc/sysctl.conf <<EOF
vm.max_map_count=262144
fs.file-max=65536
EOF

sudo sysctl --system

# Create user for best practice

sudo useradd sonar
sudo passwd sonar <<EOF 
sonar
sonar
EOF

# Install Java 

wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
sudo yum -y install ./jdk-17_linux-x64_bin.rpm
echo "#################### JAVA 17 INSTALLATION COMPLETED ##################"
java --version

## INSTALLATION

# Set up PostgreSQL 

sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo yum -y install postgresql14-server postgresql14
echo "[DONE] - Install PostgreSQL"

sudo /usr/pgsql-14/bin/postgresql-14-setup initdb
sudo systemctl enable --now postgresql-14

# Config DB

sudo sed -i '/local\s\+all\s\+all\s\+peer/ s/peer/trust/' /var/lib/pgsql/14/data/pg_hba.conf
sudo sed -i '/host\s\+all\s\+all\s\+.\+\s\+ident/ s/ident/md5/' /var/lib/pgsql/14/data/pg_hba.conf

sudo sed -i '/^#listen_addresses/s/^#//' /var/lib/pgsql/14/data/postgresql.conf

sudo sh -c 'echo "# Accept from anywhere" >> /var/lib/pgsql/14/data/pg_hba.conf'
sudo sh -c 'echo "host    all             all             0.0.0.0/0            md5" >> /var/lib/pgsql/14/data/pg_hba.conf'

sudo systemctl restart postgresql-14
echo "[DONE] - Enable remote Access to PostgreSQL"

# Set PostgreSQL admin user

sudo passwd postgres <<EOF
postgres
postgres
EOF

# sudo su - postgres << EOF 
# postgres

# EOF

sudo -i -u postgres psql -c "alter user postgres with password 'StrongPassword';"
echo "[DONE] - Set PostgreSQL admin user"

# Create a SonarQube user and database

su -l postgres -c "createdb sonarqube" << EOF
postgres
EOF

echo "[DONE] - Create sonarqube DB"

sudo -i -u postgres psql -c "CREATE USER sonarqube WITH PASSWORD 'StrongPassword';"
sudo -i -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE sonarqube to sonarqube;"

echo "[DONE] - Create sonarqube user \& grant permissions"

#Fetch and install SonarQube 

sudo -i << EOF
echo "postgres   ALL=(ALL:ALL) ALL" >> /etc/sudoers
EOF
echo "[DONE] - Add Postgres to sudoers files & elevate all privileged command"

sudo su - postgres <<EOF
postgres
cd ~/
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.1.69595.zip 
echo "[DONE] - Downloaded Sonarqube" 

unzip sonarqube-*.zip
sudo mv sonarqube-*/  /opt/sonarqube
rm -rf sonarqube*
echo "[DONE] - Place Postgres in /opt" 
EOF

## CONFIGURE

su -l postgres -c "cat  <<EOF> /opt/sonarqube/conf/sonar.properties

sonar.jdbc.username=sonarqube
sonar.jdbc.password=StrongPassword
sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube

sonar.web.javaOpts=-server -Xmx512m -Xms512m -XX:+HeapDumpOnOutOfMemoryError
sonar.search.javaOpts=-Xmx512m -Xms512m -XX:MaxDirectMemorySize=256m -XX:+HeapDumpOnOutOfMemoryError

sonar.web.host=0.0.0.0
sonar.web.port=9000

sonar.path.data=/var/sonarqube/data
sonar.path.temp=/var/sonarqube/temp

EOF" <<EOF2
postgres
EOF2

echo "[DONE] - Configure SonarQube web service"

# Give permissions

sudo su - postgres <<EOF
postgres
sudo chown -R sonar:sonar /opt/sonarqube
sudo mkdir -p /var/sonarqube
sudo chown -R sonar:sonar /var/sonarqube
EOF
echo "[DONE] - Change owner to 'sonarqube' folder"

# Config Sonarqube service

sudo -i <<EOF2
cat <<EOF> /etc/systemd/system/sonarqube.service

[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
LimitNOFILE=65536
LimitNPROC=4096
User=sonar
Group=sonar
Restart=on-failure

[Install]
WantedBy=multi-user.target

EOF
EOF2


echo "[DONE] - Config system service for sonarqube"

sudo systemctl daemon-reload
sudo systemctl start sonarqube.service
sudo systemctl enable sonarqube.service
echo "[DONE] - Config SonarQube as normal service & run with boot up"

sudo systemctl stop firewalld
echo "[DONE] - Stop firewall (or you can whitelisting port 9000)"

echo "!!! ACCESS SONARQUBE AT PORT 9000 !!!"
echo "Defaut username/password is: admin/admin"



