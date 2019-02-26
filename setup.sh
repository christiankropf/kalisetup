#!/bin/bash

#################################################################################
################### Kalisetupscript - under GPLv3             ###################
################### by Christian Kropf                        ###################
################### Thanks to the community!                  ###################
#################################################################################

clear
echo "

 _     _ _______        _____      _______ _______ _______ _     _  _____       _______ _______  ______ _____  _____  _______
 |____/  |_____| |        |        |______ |______    |    |     | |_____]      |______ |       |_____/   |   |_____]    |   
 |    \_ |     | |_____ __|__      ______| |______    |    |_____| |            ______| |_____  |    \_ __|__ |          |  
   
   "
   
# Variables
message="Setup script Kali"
update="N"

echo "$message"
echo "

"
#Abfrage ob Updates durchgeführt werden sollen 
 
read -p "Sollen Updates durchgeführt werden (y/n) :" -i n -e update
if [ $update == "y" ] 
        then 
                echo Updates werden durchgeführt:  
 
                 #Inital updates & installations
                 echo "
                 
                 "
                 apt-get update 
                 apt-get install terminator 
                 apt-get update && apt-get upgrade -y 
                 apt-get dist-upgrade -y 
                 apt-get install virtualbox-guest-x11 –y 
                 nmap --script-updatedb 
        else 
 
                echo "Keine Updates werden durchgeführt
                
                "
                
 
fi 

#install tools
echo "Default tools will be installed..."
apt-get install terminator -y
apt-get install ipcalc -y
apt-get install mtr -y
apt-get install tor
#freevulnsearch
apt-get install geoip-bin
apt-get install jq -y
#freevulnaudit
apt-get install xlstproc
apt-get install wkhtmltopdf

echo "
"

"

#Setup and configuration 
echo "Setup und configuration" 
 
      #Tastaturlayout einstellen: 
      echo "Tastataur Layout eingestellt.."
      gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'ch')]" 
      #Zeitzone einstellen:
      echo "Zeitzone eingestellt"
      timedatectl set-timezone Europe/Zurich 
      #Zeit einstellen mit ntpdate: 
      echo "Zeit korrekt eingestellt"
      apt-get install ntpdate -y 
      ntpdate ch.pool.ntp.org
      #DNS auf Google umstellen
      echo nameserver 8.8.8.8 > /etc/resolv.conf
echo "

"


#Alias setzten
echo "Alias setzten"
alias cls='clear'
echo alias cls='clear' >>~/.bashrc
alias ls='ls --color=auto'
echo "alias ls='ls -la --color=auto'" >>~/.bashrc
alias cd..='cd ..'
echo "alias cd..='cd ..'" >>~/.bashrc

#Scan
read -p "Sollen ein nmap Scan des lokalen Subnetz durchgeführt werden:(y/n):" -i y -e scan
if [ $scan == "y" ] 
        then 
                ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
                subnet=$(/sbin/ip -o -f inet addr show | awk '/scope global/ {print $4}' | cut -d/ -f2)

                echo Aktuelle IP-Adresse:
                echo $ip4
                echo Range für Scan:
                range=$(echo $ip4 | sed 's/\.[0-9]*$/.0/')
                echo $range
                 
                 scanrange=$(echo $range"/"$subnet)
                 echo "Range für Scanning:" $scanrangea
                 echo Starte Scan:
				 read -p "Soll gleich ein Audit durchgeführt werden? :(y/n):" -i y -e audit
				 if [ $audit == "y" ]
					then
						#git clone https://github.com/OCSAF/freevulnaudit.git
						#cp freevulnsearch.nse /usr/share/nmap/scripts
						git clone https://github.com/OCSAF/freevulnsearch.git
						cp freevulnsearch/freevulnsearch.nse ./
						nmap -n -Pn -sV -p- --script freevulnsearch $scanrange
					else
					nmap -n -PR -T5 $scanrange
				fi

        else 
                 echo "Es weden keine Scans durchgeführt"  
 
fi                                                                                                                                                                        
