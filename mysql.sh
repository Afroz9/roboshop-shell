echo -e "\e[33m Disable  MYSQL Default Server \e[0m"
dnf module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[33m Copy MYSQL Repo File \e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log


echo -e "\e[33m Install MYSQL community server \e[0m"
dnf install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[33m Start MySQL Service \e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log


echo -e "\e[33m MYSQL Password \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log
