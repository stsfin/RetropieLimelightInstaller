# RetropieLimelightInstaller

Just a quick bash script to automate the install of Limelight to Retropie with Emulation Station.


limelightRetroInstall.sh - script is used to install and configure limelight with retropie
limelightReconfig.sh - script is used to reconfigure ip and keymap settings for limelight without installing stuff again

Howto use:

just drop the limelightRetroInstall.sh in to your home directory

chmod +x limelightRetroInstall.sh

./limelightRetroInstall.sh

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
