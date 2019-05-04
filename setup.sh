#!/bin/bash

#################################################################################
################### kali setup script - under GPLv3           ###################
################### by Christian Kropf                        ###################
################### BETA Version                              ###################
#################################################################################

#####################################################################
#  INFORMATIONS                                           			#
#   This script sets my preffered default config to kali 			#
#   and installs my favorite tools and programs and give me			#
#	the option to scan the local network with OCSAF freevulnsearch	#
#####################################################################


###############################
### EXAMPLE TOOL USAGE TEXT ###
###############################

usage() {
	echo "Setup script Kali"
	echo "Use only with legal authorization and at your own risk!"
       	echo "ANY LIABILITY WILL BE REJECTED!"
       	echo ""	
	echo "USAGE:" 
	echo "  ./setup.sh"
       	echo "  ./setup.sh -u"	
       	echo ""	
	echo "OPTIONS:"
	echo "  -h, help - this beautiful text"
	echo "  -u, update Kali"
	echo "  -c, set my default config"
	echo "  -t, install my tools"
	echo "  -s, make a scan in the current subnet with OCSAF"
	echo "  -c, no color scheme set"
       	echo ""
	
}


###############################
### GETOPTS - TOOL OPTIONS  ###
###############################

while getopts "uctshc" opt; do
	case ${opt} in
		h) usage; exit 1;;
		u) input1="$OPTARG"; opt_arg1=1;;
		c) input2="$OPTARG"; opt_arg2=1;;
		t) input3="$OPTARG"; opt_arg3=1;;
		s) input4="$OPTARG"; opt_arg4=1;;		
		c) nocolor=1;;
		\?) echo "**Unknown option**" >&2; echo ""; usage; exit 1;;
        	:) echo "**Missing option argument**" >&2; echo ""; usage; exit 1;;
		*) usage; exit 1;;
  	esac
  	done
	shift $(( OPTIND - 1 ))

#Check if opt_arg1 or opt_arg2 or opt_arg3 or opt_arg4 is set
if [ "$opt_arg1" == "" ] && [ "$opt_arg2" == "" ] && [ "$opt_arg3" == "" ] && [ "$opt_arg4" == "" ]; then
	echo "**No argument set**"
	echo ""
	usage
	exit 1
fi


###############
### COLORS  ###
###############

greenON=""
redON=""
colorOFF=""

if [[ $color -eq 1 ]]; then
	colorOFF='\e[39m'
	greenON='\e[92m'
	redON='\e[91m'
fi


################### functions ####################

# My function for Updating Kali

funcUpdate() {
	
	local update   #Installing updates Y/N
	

	read -p "Sollen Updates durchgeführt werden (y/n) :" -i n -e update

	if [ $update == "y" ] 

        then 
                echo Updates werden durchgeführt:  

                 #Inital updates & installations
                 echo "
					"
				apt-get update 
                apt-get update && apt-get upgrade -y 
				apt-get dist-upgrade -y 
				apt-get install virtualbox-guest-x11 –y 
				
        else 
                echo "Keine Updates werden durchgeführt
				"
	fi 
}

# My function for making my default kali config

funcConfig() {
	
	local dns   #DNS-Server
	
	read -p "Welcher DNS soll gesetzt werden :" -i 8.8.8.8 -e dns
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
    echo nameserver $dns > /etc/resolv.conf
	#Alias setzten
	echo "Alias setzten"
	alias cls='clear'
	echo alias cls='clear' >>~/.bashrc
	alias ls='ls --color=auto'
	echo "alias ls='ls -la --color=auto'" >>~/.bashrc
	alias cd..='cd ..'
	echo "alias cd..='cd ..'" >>~/.bashrc

}

# My function for installing my tools

funcTools() {

	local toolsinstall   #Installing Tools Y/N
	
	read -p "Sollen Tools insalliert werden (y/n) :" -i n -e toolsinstall

	if [ $toolsinstall == "y" ] 

        then 
                echo Updates werden durchgeführt:  

                 #Inital updates & installations
                 echo "
					"
				apt-get install terminator
				apt-get install ipcalc -y
				apt-get install mtr -y
				apt-get install tor		
				apt-get install geoip-bin
				apt-get install jq -y
				apt-get install xlstproc	
				apt-get install wkhtmltopdf				
				nmap --script-updatedb 

        else 
                echo "Es werden keine Tools installiert.."
				
	fi 
}

# My function for reading the current ip and subnet f doing a scan with OCSAF freevulnsearch

funcScan() {

	local scan 		#scan Y/N
	local ip4   	#IP-Adress
	local subnet 	#cut out of inet ip inet address show
	local range 	#Range for Scanning out of IP and Subnet
	local scanrange #Scanrange

	
	read -p "Sollen ein nmap Scan des lokalen Subnetz durchgeführt werden:(y/n):" -i y -e scan
	if [ $scan == "y" ] 
	    then 
            ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
            subnet=$(/sbin/ip -o -f inet addr show | awk '/scope global/ {print $4}' | cut -d/ -f2)
            echo Aktuelle IP-Adresse: $ip4
            range=$(echo $ip4 | sed 's/\.[0-9]*$/.0/')
            echo Range für Scan: $range
            scanrange=$(echo $range"/"$subnet)
            echo "Range für Scanning:" $scanrange
            echo Starte Scan:
			git clone https://github.com/OCSAF/freevulnsearch.git
			cp freevulnsearch/freevulnsearch.nse ./
			nmap -sV --script ~/freevulnsearch $scanrange
		else 
                 echo "Es weden keine Scans durchgeführt"  
	fi  
}

####### MAIN PROGRAM #######

echo ""
echo "######################"
echo "####  Kali-Setup  ####"
echo "######################"
echo ""

if [ "$opt_arg1" == "1" ]; then
	funcUpdate
	unset update
	echo "Updates abgeschlossen"
elif [ "$opt_arg2" == "1" ]; then
		funcConfig 
		unset dns
		echo "Konfiguration abgeschlossen"
elif [ "$opt_arg3" == "1" ]; then
	funcTools 
	unset toolsinstall
	echo "Tool Installation abgeschlossen"
	echo $opt_arg4
elif [ "$opt_arg4" == "1" ]; then
	funcScan 
	unset scan
	unset ip4   	
	unset subnet
	unset range
	unset scanrange
	echo "Scan wurde durchgeführt"	
fi

################### END ###################
