# dependencies
sudo add-apt-repository ppa:aslatter/ppa
sudo add-apt-repository ppa:papirus/papirus
sudo apt update
sudo apt install alacritty
sudo apt install papirus-icon-theme
sudo apt install lxappearance brightnessctl playerctl pavucontrol feh
sudo apt install rofi picom
sudo usermod -aG video ${USER} # run brightnessctl without sudo
sudo apt install acpi # for battery info
sudo apt install maim xclip # for screenshot
sudo apt install cava # music visualizer
sudo apt install jq # jquery i3-msg workspaces for eww widgets

# i3-gaps
cd ~
sudo apt install meson libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool automake libxcb-xrm-dev libxcb-shape0-dev -y
sudo apt install asciidoc -y
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
mkdir build && cd build
meson -Ddocs=true -Dmans=true ..
meson compile -C .
sudo meson install -C .

# i3lock-color
cd ~
sudo apt install i3lock
sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh

# dunst
cd ~
sudo apt install libxinerama-dev libxrandr-dev libxss-dev libnotify-dev libgdk-pixbuf2.0-dev
git clone https://github.com/dunst-project/dunst.git
cd dunst
make WAYLAND=0
sudo make install WAYLAND=0

# eww
cd ~
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
sudo apt install libgtk-3-dev
git clone https://github.com/elkowar/eww
cd eww
cargo build --release
cd target/release
chmod +x ./eww
sudo mv eww /usr/local/bin/

# themes
cd ~/dotfiles
./papirus-folder-color.sh magenta
cd ~
git clone https://github.com/vinceliuice/Orchis-theme.git
cd Orchis-theme
./install.sh -t purple -c light
./install.sh -t purple -c dark

# fonts
mkdir ~/.fonts
cd ~/.fonts
wget https://github.com/adi1090x/rofi/blob/master/fonts/Icomoon-Feather.ttf -O Icomoon-Feather.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/M/Regular/complete/Meslo%20LG%20M%20Regular%20Nerd%20Font%20Complete.ttf -O MesloLGM-Regular-Nerd-Font.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Medium/complete/Fira%20Code%20Medium%20Nerd%20Font%20Complete.ttf -O FiraCode-Medium-Nerd-Font.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Medium/complete/Iosevka%20Medium%20Nerd%20Font%20Complete.ttf -O Iosevka-Medium-Nerd-Font.ttf
wget https://github.com/rachung2510/dotfiles/raw/master/FiraSans-Regular.ttf
fc-cache -fv ~/.fonts

cd ~/dotfiles
