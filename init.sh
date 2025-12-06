#!/bin/bash
ln -s $(pwd)/.tool-versions $HOME/.tool-versions
mkdir -p $HOME/.bin
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

echo "Installing devbox"
curl -fsSL https://get.jetify.com/devbox | bash
devbox global install
rm $HOME/.local/share/devbox/global/current/devbox.*
ln -s $(pwd)/devbox.json $HOME/.local/share/devbox/global/current/devbox.json
ln -s $(pwd)/devbox.lock $HOME/.local/share/devbox/global/current/devbox.lock
devbox global install

echo "Installing asdf"
git clone https://aur.archlinux.org/asdf-vm.git && cd asdf-vm && makepkg -si
cat .tool-versions | awk '{print $1}' | xargs -I % asdf plugin add
asdf install

echo "Installing yay"
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

echo "Installing warp terminal"
sudo sh -c "echo -e '\n[warpdotdev]\nServer = https://releases.warp.dev/linux/pacman/\$repo/\$arch' >> /etc/pacman.conf"
sudo pacman-key -r "linux-maintainers@warp.dev"
sudo pacman-key --lsign-key "linux-maintainers@warp.dev"

# Cachyos setup script
echo "updating system packages"
sudo pacman -Syu

echo "Installing global menu support"
sudo pacman -Sy appmenu-gtk-module libdbusmenu-glib switcheroo-control warp-terminal code fuse2 chromium flameshot obs-studio ghostty discord emacs fish tmux
sudo systemctl enable --now switcheroo-control # Enable dual GPU Support

echo "Installing Code Extensions"
./vscode-extensions.sh

echo "Installing Zen"
flatpak install app.zen_browser.zen

echo "Installing nordvpn"
sh <(wget -qO - https://downloads.nordcdn.com/apps/linux/install.sh)

echo "Configuring custom keybindings"
cat ~/.config/dconf/custom-keybindings.dconf | dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/
echo "Turning off screenshot noise"
sudo mv /usr/share/sounds/freedesktop/stereo/camera-shutter.oga /usr/share/sounds/freedesktop/stereo/camera-shutter-disabled.oga
