
color="\e[36m"
nocolor="${nocolor}"
log_file="&>>$log_file"
app_path="/app"

app_presetup(){
  echo -e "${color} Add Application User ${nocolor}"
  id roboshop &>>$log_file
  if [ $? -el to 1 ]; then
    useradd roboshop &>>$log_file
  fi
    if [ $? -eq 0 ]; then
        echo SUCCESS
      else
        echo FAILURE
        fi

    echo -e "${color} Create Application Directory ${nocolor}"
      rm -rf /app &>>$log_file
      mkdir /app &>>$log_file
      if [ $? -eq 0 ]; then
          echo SUCCESS
        else
          echo FAILURE
          fi



      echo -e "${color} Download application Content ${nocolor}"
        curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>$log_file
      if [ $? -eq 0 ]; then
                echo SUCCESS
              else
                echo FAILURE
                fi

    echo -e "${color} Extract Application Content ${nocolor}"
    cd ${app_path}
    unzip /tmp/$component.zip &>>$log_file
    if [ $? -eq 0 ]; then
              echo SUCCESS
            else
              echo FAILURE
              fi
}

    systemd_setup() {
      echo -e "${color} Setup SystemD File ${nocolor}"
        cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$log_file
        if [ $? -eq 0 ]; then
                  echo SUCCESS
                else
                  echo FAILURE
                  fi

        echo -e "${color} Start Shipping Service Maven ${nocolor}"
        systemctl daemon-reload &>>$log_file
        systemctl enable $component &>>$log_file
        systemctl restart $component &>>$log_file
        if [ $? -eq 0 ]; then
            echo SUCCESS
          else
            echo FAILURE
            fi
}

nodejs() {
  echo -e "${color} Configuration NodeJS Repos ${nocolor}"
  dnf module disable nodejs -y &>>$log_file
  dnf module enable nodejs:18 -y &>>$log_file

  echo -e "${color} Install NodeJS ${nocolor}"
  dnf install nodejs -y &>>$log_file

app_presetup


  echo -e "${color} Download  application Content ${nocolor}"
  curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
  cd ${app_path}

  echo -e "${color} Install NodeJS Dependencies ${nocolor}"
  npm install &>>$log_file

  systemd_setup

}
mongo_schema_setup(){
  echo -e "${color} Installing Nginx Server ${nocolor}"
  cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file

  echo -e "${color} Copy MongoDB Repo File ${nocolor}"
  dnf install mongodb-org-shell -y &>>$log_file

  echo -e "${color} Load Schema ${nocolor}"
  mongo --host mongodb-dev.afroz1.online <${app_path}/schema/$component.js &>>$log_file

}
mysql_schema_setup() {
  echo -e "${color} Install Maven Client ${nocolor}"
    dnf install mysql -y &>>$log_file

    echo -e "${color} Load Schema ${nocolor}"
    mysql -h mysql-dev.afroz1.online -uroot -pRoboShop@1 </app/schema/${component}.sql &>>$log_file
}


maven(){
  echo -e "${color} Install Maven ${nocolor}"
  dnf install maven -y &>>$log_file
  
 app_presetup

  echo -e "${color} Download Maven dependencies ${nocolor}"
  mvn clean package &>>$log_file
  mv target/${component}-1.0.jar ${component}.jar &>>$log_file
  
  mysql_schema_setup
  
  systemd_setup
}

python(){
  echo -e "${color} Install Python 3.6 ${nocolor}"
  dnf install python36 gcc python3-devel -y &>>/tmp/roboshop.log
  if [ $? -eq 0 ]; then
      echo SUCCESS
    else
      echo FAILURE
      fi


 app_presetup

  echo -e "${color} Install Application dependencies ${nocolor}"
  cd /app
  pip3.6 install -r requirements.txt &>>/tmp/roboshop.log
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
    fi
  systemd_setup

}