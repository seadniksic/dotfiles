#!/usr/bin/env bash
set -e

echo "[*] Installing dependencies..."

#install snap for alacritty
sudo apt install snapd

#install alacritty
sudo snap install alacritty --classic

#install zsh
sudo apt install zsh

#install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

echo "[*] Stowing dotfiles..."
stow alacritty nvim tmux zsh vim

echo "[*] Setup complete!"
