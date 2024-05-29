source common.sh
$componant=backend

echo -e "${color} Disable NodeJS default Version \e[0m"
dnf module disable nodejs -y &>>$log_file
status_check

echo -e "${color} Enable NodeJS 18 Version \e[0m"
dnf module enable nodejs:18 -y &>>$log_file
status_check

echo -e "${color} Install NodeJS \e[0m"
dnf install nodejs -y &>>$log_file
status_check

echo -e "${color} Copy Backend Service File \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
status_check

id expense &>>$log_file
if [ $? -ne 0 ]; then
  echo -e "${color} Add Application User \e[0m"
  useradd expense &>>$log_file
  status_check
fi

if [ ! -d /app ]; then
  echo -e "${color} Create Application Directory \e[0m"
  mkdir /app &>>$log_file
  status_check
fi

echo -e "${color} Delete old Application Content \e[0m"
rm -rf /app/* &>>$log_file
status_check

download_and_Extract

echo -e "${color} Extract Application Content \e[0m"
cd /app &>>$log_file

status_check

echo -e "${color} Download NodeJS Dependencies \e[0m"
npm install &>>$log_file
status_check

echo -e "${color} Install MySQL Client to Load Schema \e[0m"
dnf install mysql -y &>>$log_file
status_check

echo -e "${color} Load Schema \e[0m"
mysql -h 172.31.25.169 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
status_check

echo -e "${color} Starting Backend Service \e[0m"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
status_check