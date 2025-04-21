#!/bin/bash
sudo apt update
sudo apt install nginx unzip -y
cd /tmp && wget https://www.free-css.com/assets/files/free-css-templates/download/page295/kider.zip
unzip /tmp/kider.zip
sudo mv /tmp/preschool-website-template /var/www/html/preschool

# Need check
#sudo apt install openjdk-17-jdk -y
#sudo git clone https://github.com/panneergit/spc-jar.git
#sudo java -jar spring-petclinic-3.1.0-SNAPSHOT.jar