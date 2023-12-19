echo -e "\e[33mCopy Mongodb repo file\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33mInstalling Mongodb Server\e[0m"
dnf install mongodb-org -y &>>/tmp/roboshop.log

#Modify the config file
echo -e "\e[33mStart Mongodb Server\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log