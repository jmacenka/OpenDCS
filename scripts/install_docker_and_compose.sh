#!/bin/bash
# SCRIPT FOR SETTING UP DOCKER, DOCKER-COMPOSE

if [[ $EUID = 0 ]]; then
   echo "This script must not be run as 'root' user, please create a new user, add him to sudoers-group and rerun this script." 
   exit 1
fi

echo "Now: Updating your System..."
sudo apt update && sudo apt upgrade -y
sudo apt install git curl python3 -y
sudo apt install python3-pip -y

echo "Now: Installing Docker..."
curl https://get.docker.com | sh -

echo "Now: Adding current user to docker-group..."
sudo usermod -aG $USER

echo "Now: Installing docker-compose via Python3-pip..."
sudo python3 -m pip install docker-compose