#!/bin/bash

cd /home/pi/limelight

echo -e "\nDiscovering GeForce PC:s, when found you can press ctrl+c to stop the search, or it will take a long time \n"

java -jar limelight.jar discover

read -p "Input ip-address given above (if no IP is shown, press CTRL+C and check host connection) :`echo $'\n> '`" ip < /dev/tty

java -jar limelight.jar pair $ip

read -p "Press any key to continue after you have given the passcode to the Host PC... `echo $'\n> '`" -n1 -s < /dev/tty

read -p "Please ensure that your gamepad is connected to the PI for device selection, press any key to continue... `echo $'\n> '`" -n1 -s < /dev/tty

clear

lsinput|grep -e dev.input.event -e name

echo -e "\nInput device event ID-number that corresponds with your gamepad from above for keymapping \n" < /dev/tty
read -p "(if the gamepad is missing, press CTRL+C and reboot the PI with the game pad attached) :`echo $'\n> '`" USBID < /dev/tty

java -jar limelight.jar map -input /dev/input/event$USBID mapfile.map

cd /home/pi/RetroPie/roms/limelight/

read -p "Update limlight startupscripts, press anykey to continue `echo $'\n> '`" -n1 -s  < /dev/tty

echo "#!/bin/bash" > limelight720p60fps.sh
echo "cd /home/pi/limelight/ && java -jar limelight.jar stream -720 -60fps "$ip" -app Steam -mapping mapfile.map" >>  limelight720p60fps.sh

echo "#!/bin/bash" > limelight1080p30fps.sh
echo "cd /home/pi/limelight/ && java -jar limelight.jar stream -1080 -30fps "$ip" -app Steam -mapping mapfile.map" >>  limelight1080p30fps.sh

echo "#!/bin/bash" > limelight1080p60fps.sh
echo "cd /home/pi/limelight/ && java -jar limelight.jar stream -1080 -60fps "$ip" -app Steam -mapping mapfile.map" >>  limelight1080p60fps.sh

chmod +x limelight720p60fps.sh
chmod +x limelight1080p30fps.sh
chmod +x limelight1080p60fps.sh
