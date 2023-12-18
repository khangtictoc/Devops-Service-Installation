# Devop Service Installation

## CentOS

(Tested on CentOS 7) 

+ 1 VM setup Gitlab (Using docker)
+ 1 VM setup Jenkins, Docker, GCloud CLI (Manual)
+ 1 VM setup Nexus and SonarQube (Manual)


## Ubuntu 

(Tested on Ubuntu 18.04) 

+ 1 VM setup Gitlab (Using docker)
+ 1 VM setup Jenkins, Docker, GCloud CLI (Manual)
+ 1 VM setup Nexus and SonarQube (Manual)

## Usage

Boots up any VM (Centos 7):

```bash
vagrant up centos_target_1
```
Then

```bash
vagrant ssh centos_target_1
```

Choose a service to install. For example: Jenkins

```bash
git clone https://github.com/khangtictoc/Devops-Service-Installation_Gitlab-Jenkins-Nexus-SonarQube.git
cd centos
sudo chmod 744 *
./manual-jenkins.sh
```

