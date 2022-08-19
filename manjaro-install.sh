# dependencies
echo "[INFO] Installing dependencies..."
yay -S alacritty --noconfirm
yay -S papirus-icon-theme --noconfirm
yay -S lxappearance brightnessctl playerctl pavucontrol feh --noconfirm
yay -S rofi --noconfirm
sudo usermod -aG video ${USER} # run brightnessctl without sudo
yay -S acpi maim xclip gnome-terminal cava jq --noconfirm

# configs
echo -e "\n[INFO] Copying config files..."
cd ~/dotfiles
cp -r alacritty ~/.config/
cp -r cava ~/.config/
cp -r dunst ~/.config/
cp -r eww ~/.config/
cp -r i3 ~/.config/
cp -r picom ~/.config/
cp -r rofi ~/.config/

# i3lock-color
echo -e "\n[INFO] Installing i3lock-color..."
yay -S autoconf cairo fontconfig gcc libev libjpeg-turbo libxinerama libxkbcommon-x11 libxrandr pam pkgconf xcb-util-image xcb-util-xrmi --noconfirm
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
wget -qO- https://git.io/papirus-folders-install | env PREFIX=$HOME/.local sh
cd ~/dotfiles
./papirus-folder-color.sh magenta
cd ~
git clone https://github.com/vinceliuice/Orchis-theme.git
cd Orchis-theme
./install.sh -t purple -c light
./install.sh -t purple -c dark
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
# spicetify backup apply enable-devtools

# fonts
echo -e "\n[INFO] Installing fonts..."
mkdir ~/.fonts
cd ~/.fonts
wget https://github.com/adi1090x/rofi/raw/master/fonts/Icomoon-Feather.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/M/Regular/complete/Meslo%20LG%20M%20Regular%20Nerd%20Font%20Complete.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Medium/complete/Fira%20Code%20Medium%20Nerd%20Font%20Complete.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Medium/complete/Iosevka%20Medium%20Nerd%20Font%20Complete.ttf
#wget https://github.com/rachung2510/dotfiles/raw/master/FiraSans-Regular.ttf
cp ~/dotfiles/FiraSans-Regular.ttf ./
fc-cache -fv ~/.fonts

cd ~/dotfiles
