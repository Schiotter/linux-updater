#!/bin/bash
#Author: Michael Schlosser
#Mail: Michael@Schlosser.wtf
#Web: https://www.schlosser.wtf

#Functions
function exec(){
	sudo $1
}
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
read -p "Update and Upgrade now? [y/n] " -n 1 answer
if [[ $answer =~ ^[Yy]$ ]]
    then

        #Update
        text_prp "\n\napt-get update...\n"
		exec "apt-get update -y"

        #Upgrade
        text_prp "\n\napt-get upgrade..\n."
        sudo apt-get upgrade -y

        #Fix-Broken
        text_red "\n\napt-get --fix-broken install...\n"
        exec "apt-get --fix-broken install -y"

        #Purge
        text_red "\n\napt-get purge...\n"
        exec "apt-get purge -y"

        #Auto-Remove
        text_red "\n\napt-get autoremove...\n"
        exec "apt-get autoremove -y"
    else
        text_red "\nexecution canceled"
		exit
fi

#Finished
text_grn "\n\nfinished"
OS_NAME=$(grep -oP '(?<=^NAME=).+' /etc/os-release | tr -d '"')
OS_VERSION=$(grep -oP '(?<=^VERSION=).+' /etc/os-release | tr -d '"')
OS_KERNEL=$(uname -r)
text_brn "\nOS: $OS_NAME $OS_VERSION;  Kernel: $OS_KERNEL"
