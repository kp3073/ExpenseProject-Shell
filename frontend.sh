echo installing Nginx
dnf install nginx -y  >> /tmp/expense.log

echo Removing Old Nginx Contant
rm -rf /usr/share/nginx/html/*  >> /tmp/expense.log

echo downloading Expense App contant

curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >> /tmp/expense.log

echo coping the contant
cp expense.conf /etc/nginx/default.d/expense.conf >> /tmp/expense.log

echo unziping contant
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip >> /tmp/expense.log

echo restart Nginx service
systemctl enable nginx >> /tmp/expense.log

systemctl restart nginx >> /tmp/expense.log
