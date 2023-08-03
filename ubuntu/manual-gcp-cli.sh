#! /bin/bash

## PRE-INSTALL

echo "[1/3] - PRE-INSTALLATION"
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo

## INSTALL

echo "[2/3] - PRE-INSTALLATION"
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-cli

echo "[3/3] - CHECK VERSION. DONE !!!"
gcloud --version

