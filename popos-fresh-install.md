### Essential dependencies
```
sudo apt update && sudo apt upgrade
sudo apt install build-essential git gdebi vim python3 python3-pip
sudo apt install autokey
```

### Apps
- Steam
- Chrome
- Minecraft
- Login Manager Settings (Pop shop)
- Thunderbird\
```
sudo apt install thunderbird
```
- Onedrive\
[script](https://github.com/abraunegg/onedrive/blob/master/docs/ubuntu-package-install.md#distribution-ubuntu-2204)
```
wget -qO - https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /usr/share/keyrings/obs-onedrive.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/obs-onedrive.gpg] https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_22.04/ ./" | sudo tee /etc/apt/sources.list.d/onedrive.list
sudo apt-get update
sudo apt install onedrive
onedrive --synchronize
```
