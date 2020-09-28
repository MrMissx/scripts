#!/bin/bash
#
# this is an infinite loop
# hit [CTRL+C] to stop!
#
# setup your git username and email first
# better to run 
#  'git config --global credential.helper store' first
#  to store your credentials

while :
do
  clear
    echo -ne "enter source repo link: "
    read -r sourcerepo
    
    echo -ne "enter your repo link: "
    read -r cloner

    echo -e "cloning ${sourcerepo}"
    git clone "$sourcerepo" repoclone
    cd repoclone || exit 1
    sleep 0.5

    echo -e ""
    echo -e "pushing to ${cloner}"
    git push "$cloner" repoclone
    sleep 0.5

    echo -e "cleanup"
    cd ..
    rm -rf "repoclone"
    echo -e ""
    echo -e "done"
    sleep 0.5
done