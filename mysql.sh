source common.sh

echo -e "${color} Disable  MySQL Default Server ${nocolor}"
yum module disable mysql -y &>>/tmp/roboshop.log
stat_check $?

echo -e "${color} Copy MYSQL Repo File ${nocolor}"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log
stat_check $?

echo -e "${color} Install MySQL  community server ${nocolor}"
yum install mysql-community-server -y &>>/tmp/roboshop.log
stat_check $?

echo -e "${color} Start MySQL Service ${nocolor}"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log
stat_check $?

echo -e "${color} Setup MySQL  Password ${nocolor}"
mysql_secure_installation --set-root-pass $1 &>>/tmp/roboshop.log
stat_check $?