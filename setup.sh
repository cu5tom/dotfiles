#!/usr/bin/env bash
# TODO: Check if stow is installed
sudo apt install stow

# TODO: Check if tmux-tpm is present
git clone https://github.com/tmux-tpm/tpm ~/.tmux/plugins/tpm

stow bash
stow fish
stow ghostty
stow lazygit
stow nvim
stow sesh
stow starship
stow tmux
