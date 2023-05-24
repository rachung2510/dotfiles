# Rice Setup
<img src="https://github.com/rachung2510/dotfiles/blob/master/screenshots/sidebar-menu.png?raw=true" alt="Home Page" width="800" />
<img src="https://github.com/rachung2510/dotfiles/blob/master/screenshots/dark-theme.gif?raw=true" alt="Home Page" width="800" />
<img src="https://github.com/rachung2510/dotfiles/blob/master/screenshots/light-theme.png?raw=true" alt="Home Page" width="800" />

# Features
- i3wm
- Vertical taskbar **(System tray not integrated)**
- Sidebar menu
- Light + dark theme switch
- Workspace icon changes based on window + manual setting of workspace icon via dmenu

# Installation
Run ```arch_install.sh```.

# Keybinds
Default i3 keybinds unless otherwise stated.
Key | Action
--- | ---
Ctrl+Shift+Q | Close window (replaces Mod+Shift+Q)
Mod+q | Toggle tiling (replaces Mod+e used for opening file explorer)
Mod+p | Focus parent (replaces Mod+a)
Mod+Shift+Enter | Open floating terminal
Mod+Space | Switch language (ibus) (replaces "focus floating/tiling")
Mod+(Shift+)Tab | Cycle between workspaces
Alt+(Shift+)Tab| Cycle between containers in a workspace
Ctrl+Space | Clear newest notification
Ctrl+Shift+Space | Clear all notifications
Mod+/ | Open app launcher (dmenu -drun)
Mod+. | Switch light/dark theme
Mod+, | Set workspace icon
Mod+m | Toggle sidebar menu
Mod+b | Toggle between eww taskbar and i3bar (usually to show system tray)

# Configuration
- WM: [i3-gaps](https://www.github.com/Airblader/i3)
- Lock screen: i3lock-color
- Launcher, Powermenu: [rofi](https://github.com/adi1090x/rofi)
- Dmenu: [rofi](https://github.com/Murzchnvok/rofi-collection)
- Compositor: picom
- Notifications: [dunst](https://github.com/dunst-project/dunst)
- Widgets: [eww](https://github.com/elkowar/eww) ([Documentation](https://elkowar.github.io/eww/widgets.html))\
Reference: [Gwydo](https://github.com/Gwyd0/Linuxsetup)
- Terminal: Alacritty

### Fonts
- [Noto Sans Medium Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Noto/Sans/complete/Noto%20Sans%20Medium%20Nerd%20Font%20Complete.ttf)
- [MesloLGM Regular Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/M/Regular/complete/Meslo%20LG%20M%20Regular%20Nerd%20Font%20Complete.ttf)
- [FiraCode Medium Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Medium/complete/Fira%20Code%20Medium%20Nerd%20Font%20Complete.ttf)
- [Iosevka Medium Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Iosevka/Medium/complete/Iosevka%20Medium%20Nerd%20Font%20Complete.ttf)
- [Icomoon Feather](https://github.com/adi1090x/rofi/blob/master/fonts/Icomoon-Feather.ttf)

### Themes
- Icon theme: [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) (Magenta)
- GTK theme: [Orchis](https://github.com/vinceliuice/Orchis-theme) (Purple)
- Spotify theme: [Spicetify](https://spicetify.app/docs/getting-started) (Sleek - Elementary)
