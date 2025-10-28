#!/usr/bin/env bash
# Check if stow is installed
if ! hash stow >/dev/null 2>&1 then
  sudo apt install stow
fi

# Check if tmux-tpm is present
if [ ! -f ~/.tmux/plugins/tpm/bin/install_plugins ]; then
  git clone https://github.com/tmux-tpm/tpm ~/.tmux/plugins/tpm
fi

stow -S bash fish lazygit nvim sesh starship tmux
