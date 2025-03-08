#!/usr/bin/env bash
# TODO: Check if stow is installed
sudo apt install stow

# TODO: Check if tmux-tpm is present
git clone https://github.com/tmux-tpm/tpm ~/.tmux/plugins/tpm

stow .
