log_file=/tmp/expense.log



status_check(){
    if [ $? -eq 0 ]; then
    echo -e "\e[32mSuccess\e[0m"
    else
    echo -e "\e[31mFailed\e[0m"
    exit 1
   fi
}