#!/bin/bash

# Update the package list
echo "Updating package list..."
sudo apt update

# Install Nginx
echo "Installing Nginx..."
sudo apt install nginx -y

# Start the Nginx service
echo "Starting Nginx..."
sudo systemctl start nginx

# Enable Nginx to start on boot
echo "Enabling Nginx to start on boot..."
sudo systemctl enable nginx

# Check the status of Nginx
echo "Checking Nginx status..."
sudo systemctl status nginx --no-pager

# Print completion message
echo "Nginx installation and setup completed!"
