echo -e "\e[33mConfiguration NodeJS Repos\e[0m"
dnf module disable nodejs -y &>>/tmp/roboshop.log
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log

echo -e "\e[33mInstall NodeJS\e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33mAdd Application User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m Create Application Directory \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[33mDownload  application Content\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app



echo -e "\e[33mExtract Application Content\e[0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[3333mInstall NodeJS Dependencies\e[0m"
npm install &>>/tmp/roboshop.log


echo -e "\e[33mSetup SystemD Service\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[33mStart Catalogue Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log

echo -e "\e[33mInstalling Nginx Server\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33mCopy MongoDB Repo File\e[0m"
dnf install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[33mLoad Schema\e[0m"
mongo --host mongodb-dev.afroz1.online </app/schema/catalogue.js &>>/tmp/roboshop.log