# Tmux
alias t='sesh connect $(sesh list | fzf)'
alias tc='tmux attach'
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new -s'
alias tl='tmux ls'
alias tk='tmux kill-session -t'

# Editor
alias vim=nvim
alias vi=nvim
alias v=nvim

# Dev
alias gg=lazygit
alias gb='git checkout -b'
alias gc='git commit'
alias gp='git pull'
alias gP='git push'
