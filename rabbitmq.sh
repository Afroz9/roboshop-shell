echo -e "\e[33mConfigure Eelang Repos \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log

echo -e "\e[33mConfigure YUM Repos for RabbitMQ\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/roboshop.log

echo -e "\e[33mInstall RabbitMQ Server \e[0m"
dnf install rabbitmq-server -y &>>/tmp/roboshop.log

echo -e "\e[33mStart RabbitMQ Service\e[0m"
systemctl enable rabbitmq-server&>>/tmp/roboshop.log
systemctl restart rabbitmq-server &>>/tmp/roboshop.log

echo -e "\e[33mAdd RabbitMQ  Application User \e[0m"
rabbitmqctl add_user roboshop roboshop123 &>>/tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log

