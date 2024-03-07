#!/bin/bash
# Ask for the username
echo -n "Enter the username: "
read username

# Ask for the real name
echo -n "Enter the full name: "
read fullname

# Add the user
sudo useradd -c "$fullname" -m $username

# Check if the user was created successfully
if [ $? -eq 0 ]; then
    echo "User has been created successfully."
else
    echo "Failed to create the user."
    exit 1
fi

# Set the password for the user
echo -n "Enter the password: "
read -s password
echo $password | sudo passwd --stdin $username

# Check if the password was set successfully
if [ $? -eq 0 ]; then
    echo "Password has been set successfully."
else
    echo "Failed to set the password."
fi
