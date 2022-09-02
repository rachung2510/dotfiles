# dependencies
echo "[INFO] Installing dependencies..."
yay -S alacritty lxappearance-gtk3 brightnessctl playerctl pavucontrol feh acpi maim xclip cava autotiling --noconfirm
sudo usermod -aG video ${USER} # run brightnessctl without sudo

# configs
echo -e "\n[INFO] Copying config files..."
cd ~/dotfiles
cp -r alacritty ~/.config/
cp -r dunst ~/.config/
cp -r eww ~/.config/
cp -r i3 ~/.config/
cp -r picom ~/.config/
cp -r rofi ~/.config/
sudo mkdir /etc/media
sudo cp ~/i3/wallpapers/blue-purple-city.jpg /etc/media/
sudo ln -t /usr/local/bin/  ~/.config/i3/scripts/picom-toggle

# i3lock-color
echo -e "\n[INFO] Installing i3lock-color..."
cd ~
yay -S autoconf cairo fontconfig gcc libev libjpeg-turbo libxinerama libxkbcommon-x11 libxrandr pam pkgconf xcb-util-image --noconfirm
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh

# eww
echo -e "\n[INFO] Installing eww..."
cd ~
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
sudo apt install libgtk-3-dev -y
git clone https://github.com/elkowar/eww
cd eww
cargo build --release
cd target/release
chmod +x ./eww
sudo mv eww /usr/local/bin/

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
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R

# fonts
echo -e "\n[INFO] Installing fonts..."
mkdir ~/.fonts
cd ~/.fonts
wget https://github.com/adi1090x/rofi/raw/master/fonts/Icomoon-Feather.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/M/Regular/complete/Meslo%20LG%20M%20Regular%20Nerd%20Font%20Complete.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Medium/complete/Fira%20Code%20Medium%20Nerd%20Font%20Complete.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Medium/complete/Iosevka%20Medium%20Nerd%20Font%20Complete.ttf
cp ~/dotfiles/FiraSans-Regular.ttf ./
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
spicetify backup apply enable-devtools"
