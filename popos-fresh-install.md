### Essential dependencies
```
sudo apt update && sudo apt upgrade
sudo apt install build-essential git gdebi vim python3 python3-pip
sudo apt install openjdk-18-jdk -y
sudo apt install autokey
sudo apt install blueman # bluetooth manager
```

### Apps
- Steam
- Chrome
- Minecraft
- Login Manager Settings (Pop shop)
- Thunderbird
```
sudo apt install thunderbird
```
- Onedrive\
[Clean ppa](https://github.com/abraunegg/onedrive/blob/master/docs/ubuntu-package-install.md#distribution-ubuntu-2204)
```
wget -qO - https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /usr/share/keyrings/obs-onedrive.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/obs-onedrive.gpg] https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_22.04/ ./" | sudo tee /etc/apt/sources.list.d/onedrive.list
sudo apt-get update
sudo apt install onedrive
onedrive --synchronize
```
- Inkscape
```
sudo add-apt-repository ppa:inkscape.dev/stable
sudo apt update
sudo apt install inkscape
```
- Spotify
```
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client
```
- Pulse Secure\
[Ubuntu zip](https://nusit.nus.edu.sg/wp-content/uploads/2022/03/pulsesecure_9.1.R14_amd64-Ubuntu-Debian.deb_.zip)
```
cd /opt/pulsesecure/bin
sudo ./setup_cef.sh install
```
