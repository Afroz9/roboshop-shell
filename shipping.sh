echo -e "\e[33mInstall Maven \e[0m"
dnf install maven -y &>>/tmp/roboshop.log

echo -e "\e[33mAdd application User \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mCreate Application Directory \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m Download application Content \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log

echo -e"\e[33m Extract Application Content \e[0m "
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[33mDownload Maven dependencies \e[0m"
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log

echo -e "\e[3333mInstall Maven Client \e[0m"
dnf install mysql -y &>>/tmp/roboshop.log

echo -e "\e[33mLoad Schema \e[0m"
mysql -h mysql-dev.afroz1.online -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[33m Setup SystemD File \e[0m"
cp /home/centos/roboshop-shell/shipping.services /etc/systemd/system/shipping.service &>>/tmp/roboshop.log

echo -e "\e[33mStart Shipping Service Maven \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log