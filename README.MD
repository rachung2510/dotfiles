### Config
- WM: [i3-gaps](https://www.github.com/Airblader/i3)
```
sudo apt install meson libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool automake libxcb-xrm-dev libxcb-shape0-dev -y
sudo apt install asciidoc
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
mkdir build && cd build
meson -Ddocs=true -Dmans=true ..
meson compile -C .
sudo meson install -C .
logout
```
i3lock-color
```
# sudo apt install i3lock
sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh
```
- Launcher, Powermenu: [Rofi](https://github.com/adi1090x/rofi)
- Dmenu: [Rofi](https://github.com/Murzchnvok/rofi-collection)
- Compositor: Picom
- Notifications: [Dunst](https://github.com/dunst-project/dunst)
```
sudo apt install libxinerama-dev libxrandr-dev libxss-dev libnotify-dev libgdk-pixbuf2.0-dev
git clone https://github.com/dunst-project/dunst.git
cd dunst
make WAYLAND=0
sudo make install WAYLAND=0
```
- Widgets: [Eww](https://github.com/elkowar/eww) ([Documentation](https://elkowar.github.io/eww/widgets.html))\
Reference: [Gwydo](https://github.com/Gwyd0/Linuxsetup)
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
sudo apt install libgtk-3-dev
git clone https://github.com/elkowar/eww
cd eww
cargo build --release
cd target/release
chmod +x ./eww
sudo mv eww /usr/local/bin/
```

### Fonts
- [Noto Sans Medium Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Noto/Sans/complete/Noto%20Sans%20Medium%20Nerd%20Font%20Complete.ttf)
- [MesloLGM Regular Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/M/Regular/complete/Meslo%20LG%20M%20Regular%20Nerd%20Font%20Complete.ttf)
- [FiraCode Medium Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Medium/complete/Fira%20Code%20Medium%20Nerd%20Font%20Complete.ttf)

### Dependencies
```
sudo apt install lxappearance brightnessctl playerctl pavucontrol feh
sudo apt install rofi picom
sudo usermod -aG video ${USER} # run brightnessctl without sudo
sudo apt install acpi # for battery info
sudo apt install maim xclip # for screenshot
sudo apt install cava # music visualizer
```

### Themes
- Icon theme: [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) (Magenta)
```
sudo add-apt-repository ppa:papirus/papirus
sudo apt-get update
sudo apt-get install papirus-icon-theme
```

- GTK theme: [Orchis](https://github.com/vinceliuice/Orchis-theme)
```
git clone https://github.com/vinceliuice/Orchis-theme.git
cd Orchis-theme
./install.sh -t purple -c light
./install.sh -t purple -c dark
```

- Spotify theme: [Spicetify](https://spicetify.app/docs/getting-started) (Sleek - Elementary)
```
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
# on a new shell
sudo chmod a+wr /usr/share/spotify
sudo chmod a+wr /usr/share/spotify/Apps -R
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh
spicetify # generate config file
spicetify backup apply enable-devtools
```


