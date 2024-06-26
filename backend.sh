source common.sh



echo -e "${color} Disable NodeJS default Version \e[0m"
dnf module disable nodejs -y &>>$log_file

echo -e "${color} Enable NodeJS 18 Version \e[0m"
dnf module enable nodejs:18 -y &>>$log_file

echo -e "${color} Install NodeJS \e[0m"
dnf install nodejs -y &>>$log_file

echo -e "${color} Copy Backend Service File \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file

id expense &>>$log_file
if [ $? -ne 0 ]; then
  echo -e "${color} Add Application User \e[0m"
  useradd expense &>>$log_file
fi

  echo -e "${color} Create Application Directory \e[0m"
  mkdir /app &>>$log_file

echo -e "${color} Delete old Application Content \e[0m"
rm -rf /app/* &>>$log_file

echo -e "${color} Download Application Content \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file

echo -e "${color} Extract Application Content \e[0m"
cd /app &>>$log_file
unzip /tmp/backend.zip &>>$log_file

echo -e "${color} Download NodeJS Dependencies \e[0m"
npm install &>>$log_file

echo -e "${color} Install MySQL Client to Load Schema \e[0m"
dnf install mysql -y &>>$log_file

echo -e "${color} Load Schema \e[0m"
mysql -h 172.31.25.169 -uroot -p$ExpenseApp@1 < /app/schema/backend.sql &>>$log_file

echo -e "${color} Starting Backend Service \e[0m"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
