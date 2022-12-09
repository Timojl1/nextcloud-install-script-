#!/bin/bash

# This script installs the latest version of Nextcloud on your system.

# Check if the user is root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Update system
apt-get update && apt-get upgrade -y

# Install required packages
apt-get install apache2 mariadb-server libapache2-mod-php7.2 -y

# Download the Nextcloud package
wget https://download.nextcloud.com/server/releases/latest.zip

# Unzip the package
unzip latest.zip

# Move the package to web directory
mv nextcloud /var/www/html/

# Set directory permissions
chown -R www-data:www-data /var/www/html/nextcloud/

# Set Apache configuration
echo 'Alias /nextcloud "/var/www/html/nextcloud/"
<Directory /var/www/html/nextcloud/>
  Options +FollowSymlinks
  AllowOverride All
 <IfModule mod_dav.c>
