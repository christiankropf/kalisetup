# Variables
message="Test setup script"
#Inital updates & installations

#apt-get update
#apt-get install terminator
#apt-get update && apt-get upgrade -y
#apt-get dist-upgrade -y
#apt-get install virtualbox-guest-x11 –y
#apt-get install terminator (Praktische Terminator Shell)
#nmap --script-updatedb

#Setup and configuration
echo "$message"

＃ Tastaturlayout einstellen:
dpkg-reconfigure keyboard-configuration
＃ Zeitzone einstellen:
dpkg-reconfigure tzdata
＃ Zeit einstellen mit ntpdate:
apt-get install ntpdate -y
ntpdate ch.pool.ntp.org
