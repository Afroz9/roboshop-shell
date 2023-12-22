source common.sh
component=catalogue


nodejs

echo -e "${color} Installing Nginx Server ${nocolor}"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file

echo -e "${color} Copy MongoDB Repo File ${nocolor}"
dnf install mongodb-org-shell -y &>>$log_file

echo -e "${color} Load Schema ${nocolor}"
mongo --host mongodb-dev.afroz1.online <${app_path}/schema/$component.js &>>$log_file