log_file=/tmp/expense.log
dnf module disable mysql -y &>>$log_file

cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file

dnf install mysql-community-server -y &>>$log_file

systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>log_file