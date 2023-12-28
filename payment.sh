
source common.sh
component=payment


roboshop_app_password=$1
if [ -z "$mysql_root_password" ]; then
  echo mysql_root_password is missing
  exit 1
fi
python