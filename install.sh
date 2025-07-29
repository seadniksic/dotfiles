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

if ! command -v tmux &> /dev/null; then
    echo "installing tmux..."
    sudo apt install tmux
else
    echo "tmux is already installed!"
fi

if ! command -v curl &> /dev/null; then
    echo "installing curl..."
    sudo apt install curl
else
    echo "curl is already installed!"
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
sudo mv /opt/nvim-linux-x86_64 /opt/nvim
sudo ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim
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

# remove default created .zshrc
rm ~/.zshrc
sudo apt install stow
stow --target="$HOME" alacritty nvim tmux zsh vim starship

echo "[*] Installing Nerd Font"

#ngl this is all chatgpt
NERD_FONT="FiraCode"
VERSION="3.1.1"
ZIP_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v${VERSION}/${NERD_FONT}.zip"
TMP_DIR="/tmp/${NERD_FONT}-nerdfont"

# Create temp directory
mkdir -p "$TMP_DIR"
cd "$TMP_DIR" || exit

# Download the font zip
echo "Downloading ${NERD_FONT} Nerd Font..."
curl -LO "$ZIP_URL"

# Unzip it
echo "Unzipping..."
unzip -q "${NERD_FONT}.zip" -d "${NERD_FONT}"

# Create local fonts dir if needed
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# Copy .ttf files
echo "Installing fonts to $FONT_DIR..."
find "${NERD_FONT}" -type f -name "*.ttf" -exec cp {} "$FONT_DIR" \;

# Update font cache (Linux only)
if command -v fc-cache &>/dev/null; then
    echo "Updating font cache..."
    fc-cache -f "$FONT_DIR"
fi

echo "✅ ${NERD_FONT} Nerd Font installed!"

echo "[*] Setup complete!"
