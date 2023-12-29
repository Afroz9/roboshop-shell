
echo -e "{color} Install GoLang{nocolor}"
dnf install golang -y &>>/tmp/roboshop.log

echo -e "{color} Create Application User{nocolor}"
useradd roboshop &>>/tmp/roboshop.log


echo -e "{color} Create App directory{nocolor}"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "{color} Download the application code to created app directory{nocolor}"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app


echo -e "{color} Extract Application Content {nocolor}"
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log


echo -e "{color} Lets download the dependencies & build the software{nocolor}"
cd /app
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -e "{color} Start the service dispatch{nocolor}"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl restart dispatch &>>/tmp/roboshop.log