# basic aliases
alias ls='ls --color=none -F'
alias ll='ls -lFh'
alias la='ls -alFh'
alias mc='TERM=xterm-256color mc'
alias ..='cd ..'
alias q='exit'
alias c='clear'
alias rm='rm -Iv'
alias cp='cp -v'
alias mv='mv -v'
alias ack='ack-grep'
alias t='todo.sh'
alias tmux='tmux -2'

# functions
function _error() {
    echo "[ !! ] $@"
    return 1
}

function s() {
    if [[ $# -ne 1 ]]; then
        _error "No session name provided";
        return 1
    else
        tmux -q has -t "$1" && tmux att -d -t "$1" || tmux new -s "$1"
    fi
}

# vim: ft=sh
