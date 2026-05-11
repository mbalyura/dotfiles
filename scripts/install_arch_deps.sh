# pacman

sudo pacman -Syu niri xwayland-satellite xdg-desktop-portal-gnome xdg-desktop-portal-gtk qt6-multimedia-ffmpeg

sudo pacman -S \
alacritty micro firefox tmux btop networkmanager \
git base base-devel \
nautilus gnome-keyring \
cliphist \
# screenshot stuff
grim slurp satty \
hyprpicker \
ttf-fira-code ttf-jetbrains-mono-nerd \
fastfetch \
# yazi stuff
yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick ueberzugpp


# yay

yay -S noctalia-shell \
dragon-drop


# after install

sudo systemctl enable --now NetworkManager
# enable dark theme for naitilus
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
dconf write /org/gnome/desktop/interface/color-scheme \'"prefer-dark"\'
