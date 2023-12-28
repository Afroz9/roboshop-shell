source common.sh

echo -e "${color}Copy Mongodb repo file ${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}Installing Mongodb Server${nocolor}"
yum install mongodb-org -y &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}Update Mongodb Listen Address${nocolor}"
sed -i  's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat_check $?

echo -e "${color}Start Mongodb Server${nocolor}"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
stat_check $?