#!/bin/bash

## Ensure the Filesystem is Read-Write

# delete the ".Xauthority" file if exists

file="/root/.Xauthority"

if  [ -e "$file" ]; then
#Remount the filesystem as read-write:
sudo mount -o remount,rw /
echo "remounted"
#Become the root user:
#sudo -i
sudo rm -f $file
echo "the file was already exist and  the file was deleted"
fi

echo "the file is not exist now "
#Create an empty .Xauthority file:
touch /root/.Xauthority

#Set the correct ownership and permissions:
chown root:root /root/.Xauthority
chmod 600 /root/.Xauthority
echo "The file created and the permission edited"





