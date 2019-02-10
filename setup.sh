# Variables
message="Test setup script"
update="N"

echo "$message"
#!/bin/bash
#Abfrage ob Updates durchgeführt werden sollen

read -p "Sollen Updates durchgeführt werden (Y/N):" update
If update="Y"
    echo Updates werden durchgeführt: 

    #Inital updates & installations
    apt-get update
    apt-get install terminator
    apt-get update && apt-get upgrade -y
    apt-get dist-upgrade -y
    apt-get install virtualbox-guest-x11 –y
    nmap --script-updatedb
Else

#Setup and configuration
echo "Setup und configuration"

＃ Tastaturlayout einstellen:
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"
＃ Zeitzone einstellen:
timedatectl set-timezone Europe/Zurich
＃ Zeit einstellen mit ntpdate:
apt-get install ntpdate -y
ntpdate ch.pool.ntp.org


