# if status is-interactive
#     # Commands to run in interactive sessions can go here
# end

# Tmux
abbr t 'sesh connect $(sesh list | fzf)'
# abbr t tmux
abbr tc 'tmux attach'
abbr ta 'tmux attach -t'
abbr tad 'tmux attach -d -t'
abbr ts 'tmux new -s'
abbr tl 'tmux ls'
abbr tk 'tmux kill-session -t'

# Editor
abbr vim nvim
abbr vi nvim
abbr v nvim

# Dev
abbr gg lazygit
abbr gb 'git checkout -b'
abbr gc 'git commit'
abbr gp 'git pull'
abbr gP 'git push'

starship init fish | source
