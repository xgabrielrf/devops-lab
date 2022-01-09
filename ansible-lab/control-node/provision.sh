#!/bin/bash
echo "Stating provision.sh..."
sudo yum -y install epel-release
echo "Installing ansible..."
sudo yum -y install ansible
echo "Changing hosts file..."
cat <<EOT >> /etc/hosts
192.168.2.102 control-node
192.168.2.103 app01
192.168.2.104 db01
EOT
echo "Done!"