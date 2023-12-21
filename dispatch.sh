
echo -e "\e[33m Install GoLang\e[0m"
dnf install golang -y &>>/tmp/roboshop.log


echo -e "\e[33m Create Application User\e[0m"
useradd roboshop &>>/tmp/roboshop.log


echo -e "\e[33m Create App directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[33m Download the application code to created app directory\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app


echo -e "\e[33m Extract Application Content \e[0m"
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log


echo -e "\e[33m Lets download the dependencies & build the software\e[0m"
cd /app
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -e "\e[33m Start the service dispatch\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl restart dispatch &>>/tmp/roboshop.log