#!/usr/bin/env fish

# Check if stow is installed
if command -v stow >/dev/null 2>&1; else
  sudo apt install stow
end

# Check if tmux-tpm is present
if test -e ~/.tmux/plugins/tpm/bin/install_plugins; else
  git clone https://github.com/tmux-tpm/tpm ~/.tmux/plugins/tpm
end
