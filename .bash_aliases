# basic aliases
alias ls='ls --color=none -F'
alias ll='ls -lFh'
alias la='ls -alFh'
alias mc='TERM=xterm-256color mc'
alias ..='cd ..'
alias q='exit'
alias c='clear'
alias v='vim'
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
        tmux -q ls
    else
        tmux -q has -t "$1" && tmux att -d -t "$1" || tmux new -s "$1"
    fi
}

# git helpers
function git-merged-remote() {
    for branch in `git branch -r --merged | grep -v HEAD`; do echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\t$branch; done | sort -r
}

function git-no-merged-remote() {
    for branch in `git branch -r --no-merged | grep -v HEAD`; do echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\t$branch; done | sort -r
}

# vim: ft=sh
