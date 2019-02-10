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


~                                                                                                                                                                                                                  
~                                                                                                                                                                                                                  
~                                                                                                                                                                                                                  
~                                                                                                                                                                                                                  
~                                                                                                                                                                                                                  
~                                                                                                                                                                                                                  
~                                                                                                                                                                                                                  
~                                                                                                                                                                                                                  
~                                                                                                                                                                                                                  
~                                                                                                                                                                                                                  
~                                                                                                                                                                                                                  
~                                                                                                                                                                                                                  
~                                                                                                                                                                                                                  
~                                                                                                                                                                                                                  
-- VISUAL --                                                                                                                                                                           33        6,10          All



