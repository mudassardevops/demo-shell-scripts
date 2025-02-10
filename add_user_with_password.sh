#!/bin/bash

# Function to check if a user exists
user_exists() {
    id "$1" &>/dev/null
}

# Prompt for username
read -p "Enter the username: " username

# Check if the user already exists
if user_exists "$username"; then
    echo "User '$username' already exists. Exiting."
    exit 1
fi

# Prompt for password (hidden input)
read -sp "Enter the password: " password
echo

# Create the user
sudo useradd -m -s /bin/bash "$username"

# Check if user creation was successful
if [ $? -eq 0 ]; then
    echo "User '$username' created successfully."
else
    echo "Failed to create user '$username'. Exiting."
    exit 1
fi

# Set the password for the user
echo "$username:$password" | sudo chpasswd

# Check if password setting was successful
if [ $? -eq 0 ]; then
    echo "Password for user '$username' set successfully."
else
    echo "Failed to set password for user '$username'."
    exit 1
fi

echo "User '$username' added with password successfully."
