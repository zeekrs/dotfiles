# instead default
alias vim=nvim
alias vimdiff="nvim -d"

alias ls='eza --color=always --group-directories-first'
alias la='eza -a --color=always --group-directories-first'
alias ll='eza -la --color=always --icons --group-directories-first'
alias lt='eza -aT --color=always --icons --group-directories-first'
alias l.='eza -a | egrep "^\."'

alias sed=gsed

alias cat='bat --paging=never'

alias cdtmp='cd $(mktemp -d /tmp/zeekrs-XXXXXX)'

alias python=python3
alias pip=pip3

# https://github.com/alacritty/alacritty/issues/1208
alias ssh='TERM=xterm-256color /usr/bin/ssh'

alias clear='echo -en "\x1b[2J\x1b[1;1H"; print_spark_line'
