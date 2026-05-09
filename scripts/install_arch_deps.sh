# pacman

sudo pacman -Syu niri xwayland-satellite xdg-desktop-portal-gnome xdg-desktop-portal-gtk qt6-multimedia-ffmpeg

sudo pacman -S \
alacritty micro firefox tmux btop networkmanager \
nautilus gnome-keyring \
cliphist \
ttf-fira-code \
yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick


# yay

yay -S noctalia-shell \
dragon-drop


# after install

sudo systemctl enable --now NetworkManager
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
dconf write /org/gnome/desktop/interface/color-scheme \'"prefer-dark"\'
