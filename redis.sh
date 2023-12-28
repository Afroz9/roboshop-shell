source common.sh

echo -e "${color}Install Redis Repos ${nocolor}"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}Enable Redis 6.2 Version${nocolor}"
dnf module enable redis:remi-6.2 -y &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}Install Redis${nocolor}"
dnf install redis -y &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}Update Redis listen address${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf  /etc/redis/redis.conf &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}Start Redis Service${nocolor}"
systemctl enable redis &>>/tmp/roboshop.log
systemctl start redis &>>/tmp/roboshop.log
stat_check $?