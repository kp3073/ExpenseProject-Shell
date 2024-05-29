log_file=/tmp/expense.log
dnf module disable nodejs -y &>>$log_file

dnf module disable nodejs -y &>>$log_file

dnf install nodejs -y &>>$log_file

cp backend.service /etc/systemd/system/backend.service &>>$log_file

useradd expense &>>$log_file

mkdir /app &>>$log_file

rm -rf /app/* &>>$log_file

curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file

cd /app &>>$log_file
unzip /tmp/backend.zip &>>$log_file

npm install &>>$log_file

dnf install mysql -y &>>$log_file

mysql -h 172.31.25.169 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>log_file

systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file