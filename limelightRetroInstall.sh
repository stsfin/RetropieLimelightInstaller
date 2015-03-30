#!/bin/bash

#install needed software from apt

read -p "Press anykey to start Java8 install, input sudo credentials if asked `echo $'\n> '`" -n1 -s

sudo apt-get update && sudo apt-get install oracle-java8-jdk && sudo apt-get install input-utils

#create folders for install

mkdir /home/pi/limelight
mkdir /home/pi/RetroPie/roms/limelight

#install reconfigure script to emulation station

cp limelightReconfig.sh /home/pi/RetroPie/roms/limelight/ 

#download limelight

cd /home/pi/limelight

wget https://github.com/irtimmer/limelight-embedded/releases/download/v1.2.1/libopus.so

wget https://github.com/irtimmer/limelight-embedded/releases/download/v1.2.1/limelight.jar

clear

echo -e "\nDiscovering GeForce PC:s, when found you can press ctrl+c to stop the search, or it will take a long time \n"

#discover IP-addresses of Geforce pc:s

java -jar limelight.jar discover

echo -e "\n"

#ask user for IP-number input for pairing

read -p "Input ip-address given above (if no IP is shown, press CTRL+C and check host connection) :`echo $'\n> '`" ip

#pair pi with geforce experience

java -jar limelight.jar pair $ip

read -p "Press any key to continue after you have given the passcode to the Host PC... `echo $'\n> '`" -n1 -s

read -p "Please ensure that your gamepad is connected to the PI for device selection (number only!), press any key to continue... `echo $'\n> '`" -n1 -s

clear

#print eventID-numbers and device names with lsinput

lsinput|grep -e dev.input.event -e name

#ask user for eventID number for keymapping

echo -e "\nInput device event ID-number that corresponds with your gamepad from above for keymapping \n"
read -p "(if the gamepad is missing, press CTRL+C and reboot the PI with the game pad attached) :`echo $'\n> '`" USBID

#run limelight keymapping

java -jar limelight.jar map -input /dev/input/event$USBID mapfile.map



#Install limelight to Emulation Station as its own device menu

read -p "Installing limelight menu to Emulation Station, press anykey to continue `echo $'\n> '`" -n1 -s
sudo sed -i -e 's|</systemList>|<system>\n<name>limelight</name>\n<fullname>Limelight</fullname>\n<path>~/RetroPie/roms/limelight</path>\n<extension>.sh .SH</extension>\n<command>bash %ROM%</command>\n<platform>limelight</platform>\n<theme>limelight</theme>\n</system>\n</systemList>|g' /etc/emulationstation/es_systems.cfg
sudo mkdir /etc/emulationstation/themes/simple/limelight
sudo mkdir /etc/emulationstation/themes/simple/limelight/art/
cd /etc/emulationstation/themes/simple/limelight
sudo wget  https://github.com/stsfin/RetropieLimelightInstaller/releases/download/1.3.1/theme.xml
cd /etc/emulationstation/themes/simple/limelight/art/
sudo wget https://github.com/stsfin/RetropieLimelightInstaller/releases/download/1.3.1/limelight.png
sudo wget https://github.com/stsfin/RetropieLimelightInstaller/releases/download/1.3.1/limelight_art.png
sudo wget https://github.com/stsfin/RetropieLimelightInstaller/releases/download/1.3.1/limelight_art_blur.png

cd /home/pi/RetroPie/roms/limelight

#Remove existing scripts if they exist

read -p "Existing limelight start scripts made with this installer will be removed, and new ones created in their place, press anykey to continue `echo $'\n> '`" -n1 -s

rm limelight720p60fps.sh 2> /dev/null
rm limelight1080p30fps.sh 2> /dev/null
rm limelight1080p60fps.sh 2> /dev/null

#Create scripts for running limelight from emulation station

echo "#!/bin/bash" >> limelight720p60fps.sh
echo "cd /home/pi/limelight/ && java -jar limelight.jar stream -720 -60fps "$ip" -app Steam -mapping mapfile.map" >>  limelight720p60fps.sh

echo "#!/bin/bash" >> limelight1080p30fps.sh
echo "cd /home/pi/limelight/ && java -jar limelight.jar stream -1080 -30fps "$ip" -app Steam -mapping mapfile.map" >>  limelight1080p30fps.sh

echo "#!/bin/bash" >> limelight1080p60fps.sh
echo "cd /home/pi/limelight/ && java -jar limelight.jar stream -1080 -60fps "$ip" -app Steam -mapping mapfile.map" >>  limelight1080p60fps.sh

#Chmod scripts to be runnable

chmod +x limelight720p60fps.sh
chmod +x limelight1080p30fps.sh
chmod +x limelight1080p60fps.sh
chmod +x limelightReconfig.sh


