#!/bin/bash
# This command to generate the ssh key and copy it to hosts
# Note : These IPs are just for testing, and it will be changed. 
ips=("54.196.61.7")

# This command to generate the ssh key and automatically enter key#
echo -ne '\n' | ssh-keygen -t rsa -b 4096
#echo -ne '\n' | ssh-keygen -t rsa -b 4096 -y
# This loop to copy the ssh key to all hosts ips
for remote_server_ip in ${ips[@]};do
  echo "Copying SSH key to $remote_server_ip"
  # Use ssh option [-o StrictHostKeyChecking=yes] to automatically accept the host key
  # This command to copy the ssh key to worker nodes
  cat ~/.ssh/id_rsa.pub | ssh -o StrictHostKeyChecking=no -i /home/ubuntu/KubeBS.pem ubuntu@$remote_server_ip 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
  #cat ~/.ssh/id_rsa.pub | ssh -i /home/ubuntu/KubeBS.pem ubuntu@$remote_server_ip 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
  ###ssh-copy-id  root@$remote_server_ip
  #ssh-copy-id -o StrictHostKeyChecking=no root@$remote_server_ip

done
