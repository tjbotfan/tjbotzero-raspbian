set -eux
set +e
killall chromium-browser
set -e
sudo raspi-config nonint do_wifi_country JP
sudo sh -c 'wpa_passphrase BMXUG TJBot2018 >> /etc/wpa_supplicant/wpa_supplicant.conf'
sudo raspi-config nonint do_camera 0
sudo raspi-config nonint do_ssh 1
sudo raspi-config nonint do_vnc 0
sudo raspi-config nonint do_resolution 2 16
sudo sh -c 'echo dtoverlay=pwm-2chan,pin=18,func=2,pin2=13,func2=4 >> /boot/config.txt'
amixer -D hw:1 sset Mic 100%
amixer -c0 sset PCM 100% unmute
sudo apt-get update
sudo apt-get install -y build-essential
curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered
bash update-nodejs-and-nodered
rm update-nodejs-and-nodered
sudo systemctl enable nodered.service
sudo apt-get install -y npm
sudo npm install -g npm
hash -r
set +e
mv ~/.node-red ~/.node-red.`date "+%Y%m%d-%H%M%S"`.bak
set -e
mkdir ~/.node-red
cd ~/.node-red
npm install node-red-node-watson
npm install node-red-dashboard
npm install node-red-contrib-camerapi
sudo apt-get install -y libasound2-dev
npm install node-red-contrib-speakerpi
npm install node-red-contrib-play-audio
npm install node-red-contrib-browser-utils
npm install node-red-node-base64
sudo apt-get install -y libopencv-dev
#hoge# npm install node-red-contrib-opencv
npm install node-red-contrib-cognitive-services
npm install node-red-contrib-google-translate
npm install node-red-contrib-cloud-vision-api
npm install node-red-contrib-model-asset-exchange
npm install node-red-contrib-hostip
npm install node-red-contrib-moment
npm install node-red-contrib-openjtalk
set +x
echo "L|o_o| < The installation process has been completed successfully!"
echo "L|o_o| < After rebooting Raspberry Pi, you can use your TJBot."
