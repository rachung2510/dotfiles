### Config
- Launcher: [Rofi Launcher](https://github.com/adi1090x/rofi)
- Dmenu: [Rofi (Dracula)](https://github.com/Murzchnvok/rofi-collection)

### Fonts
- [Noto Sans Medium Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Noto/Sans/complete/Noto%20Sans%20Medium%20Nerd%20Font%20Complete.ttf)
- [MesloLGM Regular Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/M/Regular/complete/Meslo%20LG%20M%20Regular%20Nerd%20Font%20Complete.ttf)

### Dependencies
```
sudo apt install lxappearance brightnessctl playerctl pavucontrol
sudo apt install rofi polybar
```
- i3
```
sudo apt install meson libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool automake libxcb-xrm-dev libxcb-shape0-dev -y
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
mkdir -p build && cd build
meson ..
```

### Themes
Icon theme: [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) (Violet)
```
sudo add-apt-repository ppa:papirus/papirus
sudo apt-get update
sudo apt-get install papirus-icon-theme
```

GTK theme: [Orchis](https://github.com/vinceliuice/Orchis-theme)
```
./install.sh -t purple -c light
```


