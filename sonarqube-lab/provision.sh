#!/usr/bin/bash
#Installing SonarQube
sudo useradd sonar
sudo yum install wget unzip java-11-openjdk-devel -y
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.1.0.47736.zip
sudo unzip sonarqube-9.1.0.47736.zip -d /opt/
sudo mv /opt/sonarqube-9.1.0.47736 /opt/sonarqube
sudo chown -R sonar. /opt/sonarqube

#Creating SonarQube as service
sudo echo > /etc/systemd/system/sonar.service
sudo cat <<EOT >> /etc/systemd/system/sonar.service
[Unit]
Description=SonarQube Service
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonar
Group=sonar
Restart=always

[Install]
WantedBy=multi-user.target
EOT

sudo systemctl start sonar
sudo systemctl enable sonar


#Install Sonar Scanner
sudo wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip
sudo unzip sonar-scanner-cli-4.6.2.2472-linux.zip -d /opt/
sudo mv /opt/sonar-scanner-4.6.2.2472-linux /opt/sonar-scanner
sudo chown -R sonar. /opt/sonar-scanner
sudo echo "export PATH=$PATH:/opt/sonar-scanner/bin" | sudo tee -a /etc/profile
sudo curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum install nodejs -y