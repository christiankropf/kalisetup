# Variables
message="Test setup script"

#Inital updates & installations

#apt-get update
#apt-get install terminator
#apt-get update && apt-get upgrade -y
#apt-get dist-upgrade -y
#apt-get install virtualbox-guest-x11 –y
apt-get install terminator
#nmap --script-updatedb

#Setup and configuration
echo "$message"

＃ Tastaturlayout einstellen:
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"
＃ Zeitzone einstellen:
timedatectl set-timezone Europe/Zurich
＃ Zeit einstellen mit ntpdate:
apt-get install ntpdate -y
ntpdate ch.pool.ntp.org
