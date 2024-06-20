#!/bin/bash
# This command to generate the ssh key and copy it to hosts 
# Note : These IPs are just for testing, and it will be changed. 
ips=("161.35.219.190" "134.122.78.18")

# This command to generate the ssh key and automatically enter key#
echo -ne '\n' | ssh-keygen -t rsa -b 4096 
#echo -ne '\n' | ssh-keygen -t rsa -b 4096 -y
# This loop to copy the ssh key to all hosts ips
for remote_server_ip in ${ips[@]};do
  echo "Copying SSH key to $remote_server_ip"
  # Use ssh option [-o StrictHostKeyChecking=yes] to automatically accept the host key
  ssh-copy-id  root@$remote_server_ip 
  #ssh-copy-id -o StrictHostKeyChecking=no root@$remote_server_ip 

done
