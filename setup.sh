#!/bin/bash

#################################################################################
################### Kalisetupscript - under GPLv3            ###################
################### by Christian Kropf                        ###################
################### Thanks to the community!                  ###################
#################################################################################

# Variables
message="Test setup script"
update="N"

echo "$message"
#!/bin/bash 
#Abfrage ob Updates durchgeführt werden sollen 
 
echo "Sollen Updates durchgeführt werden (Y/N):" 
read update 
echo $update 
if [ $update == "Y" ] 
        then 
                echo Updates werden durchgeführt:  
 
                 #Inital updates & installations 
                 apt-get update 
                 apt-get install terminator 
                 apt-get update && apt-get upgrade -y 
                 apt-get dist-upgrade -y 
                 apt-get install virtualbox-guest-x11 –y 
                 nmap --script-updatedb 
        else 
 
                echo Keine Updates werden durchgeführt:  
 
fi 
 
#Setup and configuration 
echo "Setup und configuration" 
 
#Tastaturlayout einstellen: 
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'ch')]" 
#Zeitzone einstellen: 
timedatectl set-timezone Europe/Zurich 
#Zeit einstellen mit ntpdate: 
apt-get install ntpdate -y 
ntpdate ch.pool.ntp.org
#Alias setzten
alias ls='ls --color=auto'

echo "alias ls='ls -la --color=auto'" >>~/.bashrc


echo "Sollen ein nmap Scan des lokalen Subnetz durchgeführt werden (Y/N):" 
read update 
echo $update 
if [ $update == "Y" ] 
        then 
                ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
                subnet=$(/sbin/ip -o -f inet addr show | awk '/scope global/ {print $4}' | cut -d/ -f2)

                 echo Aktuelle IP-Adresse:
                 echo $ip4
                 echo Range für Scan:
                 range=$(echo $ip4 | sed 's/\.[0-9]*$/.0/')
                 echo $range
                 
                  scanrange=$(echo $range"/"$subnet)
                  echo Range für Scanning:
                  echo $scanrange
                  echo Starte Scan:
                  nmap -n -PR -T5 $scanrange

        else 
 
                echo "Es weden keine Scans durchgeführt"  
 
fi                                                                                                                                                                         33        6,10          All



