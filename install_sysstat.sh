#!/bin/bash

# Update the package lists
sudo apt-get update

# Install the sysstat package
sudo apt-get install -y sysstat

# Enable the sysstat service
sudo sed -i 's/false/true/g' /etc/default/sysstat

# Restart the sysstat service
sudo service sysstat restart
