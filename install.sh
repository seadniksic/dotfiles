#!/usr/bin/env bash
set -e

echo "[*] Installing dependencies..."

if ! command -v snap &> /dev/null; then
    echo "installing snap..."
    #install snap for alacritty
    sudo apt install snapd
else
    echo "snap is already installed!"
fi

if ! command -v alacritty &> /dev/null; then
    echo "installing alacritty..."
    #install alacritty
    sudo snap install alacritty --classic
else
    echo "alacritty is already installed!"
fi

# if zsh isn't installed
if ! command -v zsh &> /dev/null; then
    echo "installing zsh..."
    #install zsh
    sudo apt install zsh

    #install oh my zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "zsh is already installed!"
fi

# install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo rm nvim-linux-x86_64.tar.gz

if ! command -v starship &> /dev/null; then
    #install starship for prompt customization
    curl -sS https://starship.rs/install.sh | sh
else
    echo "starship is already installed!"
fi

echo "[*] Configuring Themes..."

mkdir alacritty/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme alacritty/.config/alacritty/themes

echo "[*] Stowing dotfiles..."

sudo apt install stow
stow --target="$HOME" alacritty nvim tmux zsh vim

echo "[*] Setup complete!"
