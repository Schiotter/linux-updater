#!/bin/bash
#Author: Michael Schlosser
#Mail: Michael@Schlosser.wtf
#Web: https://www.schlosser.wtf

#Functions
function text_red(){
	echo -e "\033[0;31m$1\033[0m"
}
function text_grn(){
	echo -e "\033[0;32m$1\033[0m"
}
function text_brn(){
	echo -e "\033[0;33m$1\033[0m"
}
function text_blu(){
	echo -e "\033[0;34m$1\033[0m"
}
function text_prp(){
	echo -e "\033[0;35m$1\033[0m"
}
function text_wh(){
	echo -e "\033[1;37m$1\033[0m"
}

#Test for root privileges
if [[ $UID != 0 ]]; then
	text_red "Can't run the Updater!"
	text_wh "Please run the Updater with Super Cow Powers:"
	text_brn "sudo $0 $* or sudo !!"
	exit 1
fi

# Ask 
read -p "Update now? [y/n] " -n 1 answer
echo "" # NewLine
if [[ $answer =~ ^[Yy]$ ]]
    then

        #Update
        text_prp "\n\napt update...\n"
        sudo apt update -y
        text_prp "\n\napt-get update...\n"
        sudo apt-get update -y

        #Upgrade
        text_prp "\n\napt upgrade...\n"
        sudo apt upgrade -y
        text_prp "\n\napt-get upgrade..\n."
        sudo apt-get upgrade -y

        #Fix-Broken
        text_red "\n\napt --fix-broken install...\n"
        sudo apt --fix-broken install -y
        text_red "\n\napt-get --fix-broken install...\n"
        sudo apt-get --fix-broken install -y

        #Purge
        text_red "\n\napt purge...\n"
        sudo apt purge -y
        text_red "\n\napt-get purge...\n"
        sudo apt-get purge -y

        #Auto-Remove
        text_red "\n\napt autoremove...\n"
        sudo apt autoremove -y
        text_red "\n\napt-get autoremove...\n"
        sudo apt-get autoremove -y

        #Finished
        text_grn "\n\nUpdater finished"
        text_brn "\n$(uname -vrom)":
    else
        text_red "Canceled!"
fi
