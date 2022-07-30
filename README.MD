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
```
# i3lock-color
# sudo apt install i3lock
sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh
```
- Launcher: [Rofi Launcher](https://github.com/adi1090x/rofi) (Colorful)
- Dmenu: [Rofi](https://github.com/Murzchnvok/rofi-collection) (Dracula)
- Compositor: Picom
- Bar: [Polybar](https://github.com/adi1090x/polybar-themes) (Colorblocks)
- Notifications: Dunst
```
sudo apt install libxinerama-dev libxrandr-dev libxss-dev libnotify-dev libgdk-pixbuf2.0-dev
git clone https://github.com/dunst-project/dunst.git
cd dunst
make WAYLAND=0
sudo make install WAYLAND=0
```

### Fonts
- [Noto Sans Medium Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Noto/Sans/complete/Noto%20Sans%20Medium%20Nerd%20Font%20Complete.ttf)
- [MesloLGM Regular Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/M/Regular/complete/Meslo%20LG%20M%20Regular%20Nerd%20Font%20Complete.ttf)
- [FiraCode Medium Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Medium/complete/Fira%20Code%20Medium%20Nerd%20Font%20Complete.ttf)

### Dependencies
```
sudo apt install lxappearance brightnessctl playerctl pavucontrol feh
sudo apt install rofi polybar i3 picom
sudo usermod -aG video ${USER} # run brightnessctl without sudo
sudo apt install acpi # for polybar battery click action
```


### Themes
Icon theme: [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) (Magenta)
```
sudo add-apt-repository ppa:papirus/papirus
sudo apt-get update
sudo apt-get install papirus-icon-theme
```

GTK theme: [Orchis](https://github.com/vinceliuice/Orchis-theme)
```
./install.sh -t purple -c light
```


