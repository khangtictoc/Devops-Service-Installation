#! /bin/bash

# Refer to https://docs.gitlab.com/ee/install/docker.html#install-gitlab-using-docker-engine

read -p "Enter the port for HTTP access (the default value is 80, any conflict ?): " HTTP_PORT
read -p "Enter the port for HTTPS access (the default value is 443, any conflict ?): " HTTPS_PORT
read -p "Enter the port for SSH access (the default value is 22, any conflict ?): " SSH_PORT



curl https://get.docker.com/ > install-docker.sh
sudo chmod 744 install-docker.sh
./install-docker.sh
echo "[DONE] - Install Docker"


sudo systemctl start docker


sudo usermod -aG docker $USER
newgrp docker <<EOF
echo "Current groups: $(id -Gn)"

# Pull Gitlab image and run container
# Change default SSH port to 4444
# Avoid default port 80, change to 4000

docker run --detach \
  --hostname gitlab.example.com \
  --publish ${HTTPS_PORT:=443}:443 --publish ${HTTP_PORT:=80}:80 --publish ${SSH_PORT:=22}:22 \
  --name gitlab \
  --restart always \
  --volume $GITLAB_HOME/config:/etc/gitlab \
  --volume $GITLAB_HOME/logs:/var/log/gitlab \
  --volume $GITLAB_HOME/data:/var/opt/gitlab \
  --shm-size 256m \
  gitlab/gitlab-ee:latest
EOF

echo "Whitelisting HTTP port (${HTTP_PORT:=80})for Gitlab"
sudo firewall-cmd --permanent --add-port ${HTTP_PORT:=80}/tcp

echo "Use 'docker logs -f gitlab' to monitor the process" 
echo "When done. Try to check by 'curl localhost:${HTTP_PORT:=80}' to see the output"


