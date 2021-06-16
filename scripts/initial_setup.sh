#!/bin/sh

ENV_FILE=./../.env
if [ -f "$ENV_FILE" ]; then
    echo "Now: Using Parameters from .env file from '$FILE'..."
else 
    echo "Now: There was no .env file with your parameters, please edit them first..."
    cp "${ENV_FILE}.TEMPLATE" $ENV_FILE
    nano $ENV_FILE
fi
source $ENV_FILE

echo "Now: Updating the System.."
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

echo "Now: Installing Dependencies..."
sudo apt install -y locales sed openssl

echo "Now: Setting locale to Germany..."
sed -i 's/^# *\(de_DE.UTF-8 UTF-8\)/\1/' /etc/locale.gen
locale-gen
echo "export LC_ALL=de_DE.UTF-8" >> ~/.bashrc
echo "export LANG=de_DE.UTF-8" >> ~/.bashrc
echo "export LANGUAGE=de_DE.UTF-8" >> ~/.bashrc

echo "Now: Installing new user..."
useradd -p $(openssl passwd -crypt $USER_PASSWORD) $USER_NAME