echo disabling old Nodjs and enable New Nodjs
dnf module disable nodejs -y >> /tmp/expense.log
dnf module enable nodejs:18 -y >> /tmp/expense.log

echo Installing Nginx
dnf install nodejs -y >> /tmp/expense.log

echo adding user 
useradd expense >> /tmp/expense.log
rm -rf /app >> /tmp/expense.log
mkdir /app  >> /tmp/expense.log

echo Copying backend service file 
cp backend.service /etc/systemd/system/backend.service >> /tmp/expense.log

echo downloading backend zip file 
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip >> /tmp/expense.log
cd /app 

echo Unziping file 
unzip /tmp/backend.zip >> /tmp/expense.log

echo Installing NPM dependancies

npm install >> /tmp/expense.log

echo restarting services
systemctl daemon-reload >> /tmp/expense.log

systemctl enable backend >> /tmp/expense.log
systemctl start backend >> /tmp/expense.log

echo installing my sqld
dnf install mysql -y >> /tmp/expense.log


mysql -h 172.31.27.95 -uroot -pExpenseApp@1 < /app/schema/backend.sql  >> /tmp/expense.log