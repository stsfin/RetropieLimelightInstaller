# RetropieLimelightInstaller

Just a quick bash script to automate the install of Limelight to Retropie with Emulation Station.


limelightRetroInstall.sh - script is used to install and configure limelight with retropie

Howto use:

just run limelightRetroInstall.sh from where you unpacked the installer zip

chmod +x limelightRetroInstall.sh

./limelightRetroInstall.sh

After the install reboot your RetroPie and start the wanted limelight from Emulation Stations main menu
IP and keymap reconfig will also be available form this menu.

If you have hotplugged your controller you should run the reconfig script to input the correct eventID after reboot

<hr>

Known issues: 

60fps streaming will not work without lag since it needs the h264_freq setting pumped up on the Rasperry pi.
To get it working you need to overclock your Pi, here are the settings that worked for me:

arm_freq=1100
core_freq=500
sdram_freq=500
h264_freq=500
over_voltage=8
force_turbo=1
temp_limit=80

DISCLAIMER: Force_turbo will void your warranty since its keeps the clock on 100% without throttling, so you should use a heatsink with these settings. I will not be responsible if your cat catches fire or your pi explodes because of these

<hr>

Special thanks to the Guys from the Possibly Unsafe -youtube channel whose lime light video tutorial sparked the idea to make the install a tad easier. You can follow them here: https://www.youtube.com/channel/UCyvRzvYxTv1Zz0x--GN_Z7w

Also thanks to Ville, Matti and JoolsWillis for helping me to squash bugs.
