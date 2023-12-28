source common.sh

echo -e "${color}Configure Eelang Repos \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log

echo -e "${color}Configure YUM Repos for RabbitMQ\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/roboshop.log

echo -e "${color}Install RabbitMQ Server \e[0m"
dnf install rabbitmq-server -y &>>/tmp/roboshop.log

echo -e "${color}Start RabbitMQ Service\e[0m"
systemctl enable rabbitmq-server&>>/tmp/roboshop.log
systemctl restart rabbitmq-server &>>/tmp/roboshop.log

echo -e "${color}Add RabbitMQ  Application User \e[0m"
rabbitmqctl add_user roboshop $1 &>>/tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log

