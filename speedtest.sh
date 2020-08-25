#/usr/bin/env bash

# Checking required dependencies
function check_dep() {
    clear
    echo -e "Checking dependencies"
    sleep 1

    if command -v python3 >/dev/null 2>&1 ; then
       echo -e "\nPython found"
    else
        echo -e "\nPython not found. installing..."
        if [ "$(command -v apt-get)" != "" ]; then
            sudo apt-get install python -y
        else
            echo -e "\nDistro not suproted. \ninstall python by yourself"
        fi
    fi

    echo -e "\nchecking speedtest-cli"
    if command speedtest --version >/dev/null 2>&1 ; then
        echo -e "$(speedtest --version)"
    else
        pip3 install speedtest-cli
    fi
    
    sleep 2
}

check_dep
while :
do
    clear
    echo -e "This is an infinite loop"
    echo -e "speetest will start every 5 sec"
    echo -e "press [CTRL+Z] to exit\n"
    speedtest --bytes
    sleep 5
done