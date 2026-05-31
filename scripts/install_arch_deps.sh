# pacman
sudo pacman -Syu

sudo pacman -S \
niri xwayland-satellite xdg-desktop-portal-gnome xdg-desktop-portal-gtk qt6-multimedia-ffmpeg # recommended tools from niri
kitty tmux micro bat firefox \
git base base-devel \
networkmanager bluez bluez-utils \ # wifi & bluetooth
openvpn networkmanager-openvpn networkmanager-vpn-plugin-pptp networkmanager-pptp nm-connection-editor \ # vpn
nautilus gnome-keyring rsync ntfs-3g \ # file manager4
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
usbutils \
nodejs npm docker docker-compose docker-buildx php lazygit lazydocker # development

# yay
yay -S noctalia-shell \
visual-studio-code-bin \
google-chrome \
php74 php74-cli \
ripdrag-git \ # drag-n-drop from terminal, dragon-drop alternative
orca-slices-bin \
youtubemusic \
localsend-bin \ #send to phone
bat-asus-battery-bin # battery management

# yazi
ya pkg add "ruudjhuu/f3d-preview"
ya pkg add yazi-rs/plugins:chmod

# npm
sudo npm i -g n
sudo npm i -g npkill

# after install
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now docker.socket
sudo usermod -aG docker $USER

# enable dark theme for naitilus
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
dconf write /org/gnome/desktop/interface/color-scheme \'"prefer-dark"\'

# battery management set charge limit
sudo bat threshold 80
sudo bat persist
