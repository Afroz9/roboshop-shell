echo -e "\e[33m Install Python 3.6 \e[0m"
dnf install python36 gcc python3-devel -y&>>/tmp/roboshop.log

echo -e "\e[33m Add application User \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m Create App directory. \e[0m"
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m Download  application directory \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/payment.zip &>>/tmp/roboshop.log


echo -e "\e[33m download the dependencies \e[0m"
cd /app
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log


echo -e "\e[33m Start the service payment \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment &>>/tmp/roboshop.log
systemctl restart payment &>>/tmp/roboshop.log

