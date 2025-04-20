#!/bin/bash

# Check if 'stow' is installed
if ! command -v stow &> /dev/null; then
    echo "stow is not installed. Installing it using dnf..."
    sudo dnf install -y stow
    if [ $? -eq 0 ]; then
        echo "stow has been successfully installed."
    else
        echo "Failed to install stow. Please check your package manager or permissions."
        exit 1
    fi
else
    echo "stow is installed."
fi

# Check if 'zsh' is installed
if ! command -v zsh &> /dev/null; then
    echo "zsh is not installed. Installing it using dnf..."
    sudo dnf install -y zsh
    if [ $? -eq 0 ]; then
        echo "zsh has been successfully installed."
    else
        echo "Failed to install zsh. Please check your package manager or permissions."
        exit 1
    fi
else
    echo "zsh is installed."
fi

# Check if Oh My Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is not installed. Installing it..."
    
    # Ensure prerequisites are met
    if ! command -v curl &> /dev/null && ! command -v wget &> /dev/null; then
        echo "Neither curl nor wget is installed. Please install one of them and re-run the script."
        exit 1
    fi

    if ! command -v git &> /dev/null; then
        echo "git is not installed. Installing it using dnf..."
        sudo dnf install -y git
        if [ $? -ne 0 ]; then
            echo "Failed to install git. Please check your package manager or permissions."
            exit 1
        fi
    fi

    # Install Oh My Zsh using curl or wget
    if command -v curl &> /dev/null; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    elif command -v wget &> /dev/null; then
        sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo "Oh My Zsh has been successfully installed."
    else
        echo "Failed to install Oh My Zsh. Please check the installation script or your network connection."
        exit 1
    fi
else
    echo "Oh My Zsh is already installed."
fi

# Backup existing .zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
    echo "Backing up existing .zshrc to .zshrc.bak..."
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

# Stow the .zshrc file from the zsh folder
echo "Stowing .zshrc from the zsh folder..."
stow zsh 

if [ $? -eq 0 ]; then
    echo ".zshrc has been successfully stowed."
else
    echo "Failed to stow .zshrc. Please check your stow configuration."
    exit 1
fi

# Generate a new SSH key if it doesn't already exist
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    echo "Generating a new SSH key using ed25519..."
    ssh-keygen -t ed25519 -C "alifnuryana0@gmail.com" -f "$HOME/.ssh/id_ed25519" -N ""
    if [ $? -eq 0 ]; then
        echo "SSH key has been successfully generated."
    else
        echo "Failed to generate SSH key. Please check your SSH configuration."
        exit 1
    fi
else
    echo "SSH key already exists at $HOME/.ssh/id_ed25519."
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "Node.js is not installed. Installing it using dnf..."
    sudo dnf install -y nodejs
    if [ $? -eq 0 ]; then
        echo "Node.js has been successfully installed."
    else
        echo "Failed to install Node.js. Please check your package manager or permissions."
        exit 1
    fi
else
    echo "Node.js is already installed."
fi

# Check if pnpm is installed
if ! command -v pnpm &> /dev/null; then
    echo "pnpm is not installed. Installing it using dnf..."
    sudo dnf install -y pnpm
    if [ $? -eq 0 ]; then
        echo "pnpm has been successfully installed."
    else
        echo "Failed to install pnpm. Please check your package manager or permissions."
        exit 1
    fi
else
    echo "pnpm is already installed."
fi