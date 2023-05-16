# dependencies
echo "[INFO] Installing dependencies..."
echo root | sudo -S pacman --noconfirm -S xsettingsd xdotool
yay -S alacritty picom brightnessctl playerctl pavucontrol feh acpi maim xclip cava autotiling --noconfirm
sudo usermod -aG video ${USER} # run brightnessctl without sudo

# configs
echo -e "\n[INFO] Copying config files..."
cd ~/dotfiles
\cp -alf alacritty ~/.config/
\cp -alf dunst ~/.config/
\cp -alf eww ~/.config/
\cp -alf i3 ~/.config/
\cp -alf picom ~/.config/
\cp -alf rofi ~/.config/
sudo mkdir /etc/media
sudo cp i3/wallpapers/login-wallpaper.jpg /etc/media/
sudo mkdir /etc/xsettingsd
sudo ln -s "$(pwd)/system/xsettingsd.conf" /etc/xsettingsd/
sudo ln -s "$(pwd)/system/resume@.service" /etc/systemd/system/
sudo ln -s "$(pwd)/system/suspend@.service" /etc/systemd/system/
sudo ln -s "$(pwd)/system/picom_toggle" /usr/local/bin
sudo ln -s "$(pwd)/system/goto" /usr/local/bin
sudo systemctl enable resume@user
sudo systemctl enable suspend@user
systemctl --user start xsettingsd

# i3lock-color
echo -e "\n[INFO] Installing i3lock-color..."
cd ~
yay -S autoconf cairo fontconfig gcc libev libjpeg-turbo libxinerama libxkbcommon-x11 libxrandr pam pkgconf xcb-util-image --noconfirm
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh
cd ~
sudo rm -r i3lock-color

# eww
echo -e "\n[INFO] Installing eww..."
cd ~
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
sudo pacman -S --noconfirm gtk-layer-shell wireless_tools bc
git clone https://github.com/elkowar/eww
cd eww
cargo build --release
cd target/release
chmod +x ./eww
sudo mv eww /usr/local/bin/
cd ~
sudo rm -r eww

# themes
echo -e "\n[INFO] Installing themes..."
yay -S papirus-icon-theme --noconfirm
wget -qO- https://git.io/papirus-folders-install | sh
papirus-folders -C magenta
cd ~
git clone https://github.com/vinceliuice/Orchis-theme.git
cd Orchis-theme
./install.sh -t purple -c light
./install.sh -t purple -c dark
cd ~
sudo rm -r Orchis-theme
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R

# fonts
echo -e "\n[INFO] Installing fonts..."
cd ~/dotfiles
mkdir ~/.fonts
cp .fonts/*.ttf ~/.fonts/
cd ~/.fonts
fc-cache -fv ~/.fonts
sudo mkdir /root/.themes
sudo mkdir /root/.fonts
sudo cp -r ~/.themes/* /root/.themes/
sudo cp -r ~/.themes/* /usr/share/themes/
sudo cp ~/.fonts/* /root/.fonts/

cd ~/dotfiles
echo -e "[FINISHED].\n"
echo "Start a new terminal and run:
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh
spicetify backup apply enable-devtools

Rebind the power key at /etc/systemd/logind.conf"
