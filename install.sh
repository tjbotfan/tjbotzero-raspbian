set -eux

# Kill chromium to avoid swap
set +e
killall /usr/lib/chromium-browser/chromium-browser
set -e

# Update Raspbian
sudo apt-get update
#sudo apt-get -y upgrade
#sudo apt-get -y dist-upgrade

# OS configuration
set +e
sudo raspi-config nonint do_wifi_country JP
sudo raspi-config nonint do_camera 0
sudo raspi-config nonint do_ssh 0
sudo raspi-config nonint do_vnc 0
sudo raspi-config nonint do_resolution 2 16
sudo sh -c 'echo dtoverlay=pwm-2chan,pin=18,func=2,pin2=13,func2=4 >> /boot/config.txt'
amixer -D hw:1 sset Mic 100%
amixer -c 0 sset PCM 100% unmute
set -e

# Install Node-RED
sudo apt-get install -y build-essential
curl -L -O https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered
bash update-nodejs-and-nodered
rm update-nodejs-and-nodered
sudo systemctl enable nodered.service

# Prepare Node-RED home directory
set +e
mv ~/.node-red ~/.node-red.`date "+%Y%m%d-%H%M%S"`.bak
set -e
mkdir ~/.node-red
cd ~/.node-red

# Install Node-RED nodes
set +e
sudo apt-get install -y npm
sudo npm install -g npm
hash -r
set -e
npm install node-red-node-watson
npm install node-red-contrib-cos
npm install node-red-dashboard
sudo apt-get install -y python-picamera python3-picamera
npm install node-red-contrib-camerapi
npm install node-red-contrib-image-output
sudo apt-get install -y libasound2-dev
npm install node-red-contrib-speakerpi
npm install node-red-contrib-play-audio
npm install node-red-contrib-mic
npm install node-red-node-base64
sudo apt-get install -y libopencv-dev
npm install node-red-contrib-opencv
npm install node-red-contrib-cognitive-services
npm install node-red-contrib-google-translate
npm install node-red-contrib-cloud-vision-api
npm install node-red-contrib-qrcode
npm install node-red-contrib-model-asset-exchange
npm install node-red-contrib-embedded-file
npm install node-red-contrib-hostip
npm install node-red-contrib-moment
sudo apt-get install -y festival
npm install node-red-contrib-openjtalk
curl -L -O https://github.com/julius-speech/julius/archive/v4.5.zip
unzip v4.5.zip
cd julius-4.5
./configure
make
sudo make install
cd ..
rm -fr julius-4.5
rm v4.5.zip
npm install node-red-contrib-julius
cd node_modules/node-red-contrib-julius
npm run build

# Save sample Node-RED flow
cd ~/.node-red
curl -L -O https://raw.githubusercontent.com/tjbotfan/tjbotzero-raspbian/master/flows_raspberrypi.json

# package.json refresh
npm init -y 

# Add message catalog for Japanese hiragana
curl -L -O https://raw.githubusercontent.com/tjbotfan/tjbotzero-raspbian/master/messagecatalog_hiragana.zip
unzip messagecatalog_hiragana.zip
cp -r @node-red /usr/local/lib/node_modules/node-red/node_modules/
rm -fr @node-red messagecatalog_hiragana.zip

# Show messages
set +x
echo "((L|o_o| < The installation process has been completed successfully!"
echo "((L|o_o| < After rebooting Raspberry Pi, you can use your TJBot."
