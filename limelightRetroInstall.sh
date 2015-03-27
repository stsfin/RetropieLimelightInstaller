#!/bin/bash

read -p "Press anykey to start Java8 install, input sudo credentials when asked `echo $'\n> '`" -n1 -s

sudo apt-get update && sudo apt-get install oracle-java8-jdk

mkdir /home/pi/limelight

cd /home/pi/limelight

wget https://github.com/irtimmer/limelight-embedded/releases/download/v1.2.1/libopus.so

wget https://github.com/irtimmer/limelight-embedded/releases/download/v1.2.1/limelight.jar

java -jar limelight.jar discover

read -p "Input ip-address given above (if no IP is shown, press CTRL+C and check host connection) :`echo $'\n> '`" ip

java -jar limelight.jar pair $ip

read -p "Press any key to continue after you have given the passcode to the Host PC... `echo $'\n> '`" -n1 -s

read -p "Please ensure that your gamepad is connected to the first USB-port for key mapping, press any key to continue... `echo $'\n> '`" -n1 -s

java -jar limelight.jar map -input /dev/input/event0 mapfile.map

cd /home/pi/RetroPie/roms/ports/

read -p "Existing limelight start scripts made with this installer will be removed, and new ones created in their place, press anykey to continue `echo $'\n> '`" -n1 -s

rm limelight720p60fps.sh
rm limelight1080p30fps.sh
rm limelight1080p60fps.sh


echo "#!/bin/bash" >> limelight720p60fps.sh
echo "cd /home/pi/limelight/ && java -jar limelight.jar stream -720 -60fps "$ip" -app Steam -mapping mapfile.map" >>  limelight720p60fps.sh

echo "#!/bin/bash" >> limelight1080p30fps.sh
echo "cd /home/pi/limelight/ && java -jar limelight.jar stream -1080 -30fps "$ip" -app Steam -mapping mapfile.map" >>  limelight1080p30fps.sh

echo "#!/bin/bash" >> limelight1080p60fps.sh
echo "cd /home/pi/limelight/ && java -jar limelight.jar stream -1080 -60fps "$ip" -app Steam -mapping mapfile.map" >>  limelight1080p60fps.sh

chmod +x limelight720p60fps.sh
chmod +x limelight1080p30fps.sh
chmod +x limelight1080p60fps.sh
