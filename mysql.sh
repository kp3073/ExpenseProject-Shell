echo disable old mysql
dnf module disable mysql -y >> /tmp/expense.log 

echo coping repo file 
cp mysql.repo /etc/yum.repos.d/mysql.repo >> /tmp/expense.log

echo Installing MySql
dnf install mysql-community-server -y >> /tmp/expense.log

echo Starting MySql services

systemctl enable mysqld >> /tmp/expense.log
systemctl start mysqld  >> /tmp/expense.log
mysql_secure_installation --set-root-pass ExpenseApp@1 >> /tmp/expense.log