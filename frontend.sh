source common.sh


echo -e "${color} Installing Nginx \e[0m"
dnf install nginx -y &>>$log_file
status_check

echo -e "${color} Copy Expense Config file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
status_check

echo -e "${color} Clean Old Nginx Content \e[0m"
rm -rf /usr/share/nginx/html/* &>>$log_file
status_check

    echo -e "${color} Download $componant Application Code \e[0m"
    curl -o /tmp/$componant.zip https://expense-artifacts.s3.amazonaws.com/$componant.zip &>>$log_file
status_check

    unzip /tmp/$componant.zip &>>$log_file
status_check


echo -e "${color} Extract Downloaded Application Content \e[0m"
cd /usr/share/nginx/html &>>$log_file


echo -e "${color} Starting Nginx Service \e[0m"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
status_check

