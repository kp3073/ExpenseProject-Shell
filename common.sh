log_file=/tmp/expense.log

download_and_Extract(){

    echo -e "${color} Download $componant Application Code \e[0m"
    curl -o /tmp/$componant.zip https://expense-artifacts.s3.amazonaws.com/$componant.zip &>>$log_file
status_check

    unzip /tmp/$componant.zip &>>$log_file
status_check
}


status_check(){
    if [ $? -eq 0 ]; then
    echo -e "\e[32mSuccess\e[0m"
    else
    echo -e "\e[32mFailed\e[0m"
    fi
}