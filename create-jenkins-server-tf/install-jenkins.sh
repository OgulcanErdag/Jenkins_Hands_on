#! /bin/bash
dnf update -y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/rpm-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/rpm-stable/jenkins.io-2023.key
dnf upgrade -y
dnf install fontconfig java-21-amazon-corretto-devel -y
dnf install jenkins -y
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins
dnf install git -y

cd /opt

wget https://dlcdn.apache.org/maven/maven-3/3.9.14/binaries/apache-maven-3.9.14-bin.tar.gz
tar -zxvf apache-maven-3.9.14-bin.tar.gz
rm -f apache-maven-3.9.14-bin.tar.gz

ln -sfn apache-maven-3.9.14 maven

echo 'export M2_HOME=/opt/maven' > /etc/profile.d/maven.sh
echo 'export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh

cd 
source /etc/profile.d/maven.sh
