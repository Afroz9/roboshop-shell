echo -e "\e[33mDisable  MYSQL Default Server \e[0m"
dnf module disable mysql -y &>>/tmp/roboshop.log &>>/tmp/roboshop.log

echo -e "\e[33mInstall MYSQL community server \e[0m"
dnf install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[33mStart MySQL Service \e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log

echo -e "\e[33mMYSQL Password \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log