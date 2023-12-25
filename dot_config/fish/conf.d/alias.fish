# instead default
alias vi=nvim
alias vim=nvim
alias vimdiff="nvim -d"

alias ls='exa --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'
alias ll='exa -la --color=always --icons --group-directories-first'
alias lt='exa -aT --color=always --icons --group-directories-first'
alias l.='exa -a | egrep "^\."'


alias cm=chezmoi

alias sed=gsed

alias cat=bat

alias ps=procs

alias top=btm

alias du=dust

alias rm=trash

alias rl='trash -l'

alias cdtmp='cd $(mktemp -d /tmp/zeekrs-XXXXXX)'

alias python=python3
alias pip=pip3

#chat gpt
alias c=sgpt

# https://github.com/alacritty/alacritty/issues/1208
alias ssh='TERM=xterm-256color /usr/bin/ssh'

alias clear='echo -en "\x1b[2J\x1b[1;1H" ; echo; seq 1 (tput cols) | sort -R | spark | lolcat'
