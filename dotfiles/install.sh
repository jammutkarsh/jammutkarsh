#!/usr/bin/env bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in $HOME/dotfiles
# And also installs Homebrew Packages
############################

if [ "$#" -ne 1 ]; then
    echo "Usage: install.sh <home_directory>"
    exit 1
fi

# list of files/folders to symlink in ${$HOME}
files="zshrc zsh_history zprofile"

# Run the Homebrew Script
./mac.dev.sh

cp .zshrc $HOME/.zshrc
cp .zsh_history $HOME/.zsh_history
cp .zprofile $HOME/.zprofile
cp uctheme.zsh-theme $HOME/.oh-my-zsh/themes/uctheme.zsh-theme