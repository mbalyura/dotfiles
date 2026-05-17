# pacman
sudo pacman -Syu

sudo pacman -S \
niri xwayland-satellite xdg-desktop-portal-gnome xdg-desktop-portal-gtk qt6-multimedia-ffmpeg # recommended tools from niri
kitty tmux micro bat firefox networkmanager \
git base base-devel \
nautilus gnome-keyring rsync \ # file manager
cliphist \ # for clipboard manager
# udisks2 udiskie libappindicator \ # automount drives and show icon in tray
grim slurp satty \ # screenshot stuff
hyprpicker \ # color picker
ttf-fira-code ttf-jetbrains-mono-nerd \
btop fastfetch \
wlsunset \ # night light backend
yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick ueberzugpp # yazi stuff
imv mpv f3d \ # images video 3d
libreoffice-fresh \
nodejs npm docker docker-compose docker-buildx php lazygit lazydocker # development


# yay
yay -S noctalia-shell \
ripdrag-git \ # drag-n-drop from terminal, dragon-drop alternative
php74 php74-cli \
orca-slices-bin

# yazi
ya pkg add "ruudjhuu/f3d-preview"
ya pkg add yazi-rs/plugins:chmod

# npm
sudo npm i -g n
sudo npm i -g npkill


# after install
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now docker.socket
sudo usermod -aG docker $USER

# enable dark theme for naitilus
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
dconf write /org/gnome/desktop/interface/color-scheme \'"prefer-dark"\'
