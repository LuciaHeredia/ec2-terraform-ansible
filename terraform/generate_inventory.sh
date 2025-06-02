#!/bin/bash

# Get IPs from terraform output
IPS=$(terraform output -json instance_ips | jq -r '.[]')

# Start writing the inventory file
echo "[web]" > ../ansible/inventory.ini

# Loop through IPs and append to file
for ip in $IPS; do
  echo "$ip" >> ../ansible/inventory.ini
done

# Add SSH vars
cat <<EOF >> ../ansible/inventory.ini

[web:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/deployer-key
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF

echo "✅ Ansible inventory.ini generated."
