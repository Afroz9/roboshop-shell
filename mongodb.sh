echo -e "\e[33mCopy Mongodb repo file\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[3333mInstalling Mongodb Server\e[0m"
dnf install mongodb-org -y


#Modify the config file
echo -e "\e[33mStart Mongodb Server\e[0m"
systemctl enable mongod
systemctl restart mongod