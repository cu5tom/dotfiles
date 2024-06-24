#!/usr/bin/env bash
sudo apt install stow

git clone https://github.com/tmux-tpm/tpm ~/.tmux/plugins/tpm

stow .
