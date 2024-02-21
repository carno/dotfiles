# shellcheck shell=bash

# basic aliases
alias ..='cd ..'
alias c='[ $[$RANDOM % 10] = 0 ] && timeout 3 cmatrix; clear || clear'
alias cp='cp -v'
if [[ -x "$(command -v exa)" ]]; then
    alias l='exa -lFg'
    alias ll='exa -lFg'
    alias la='exa -alFg'
    alias tree='exa -T'
else
    alias ll='ls -lFh'
    alias la='ls -alFh'
    alias ls='ls --color=none -F'
fi
alias mc='mc -b'
alias mv='mv -v'
alias pbcopy='xclip -selection clipboard -r'
alias pbpaste='xclip -selection clipboard -o'
alias pip='python -m pip'
alias q='exit'
alias rm='rm -Iv'

# https://rhodesmill.org/brandon/2009/commands-with-comma/
alias ,alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo package-install || echo package-broken)" "$(date +"[%d/%m %H:%M]") Finished" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias ,git-up='find . -maxdepth 3 -name .git -type d -printf "%h\n" | xargs -I {} git -C {} um'
alias ,git-bdone='find . -maxdepth 3 -name .git -type d -printf "%h\n" | xargs -I {} git -C {} bdone'
alias ,myip='curl ifconfig.co/'
alias ,title='tmux rename-window "$(basename $(pwd))/$(git branch --show-current)"'

# functions
function _error() {
    echo "[ !! ] $*"
    return 1
}

function s() {
    if [[ $# -ne 1 ]]; then
        tmux -q list-sessions
    else
        tmux -q has-session -t "${1}" && tmux attach-session -d -t "${1}" || tmux new-session -s "${1}"
    fi
}

# git helpers
function ,git-merged-remote() {
    for branch in $(git branch -r --merged | grep -v HEAD); do echo -e "$(git show --format='%ci %cr %an' ${branch} | head -n 1) \t${branch}"; done | sort -r
}

function ,git-no-merged-remote() {
for branch in $(git branch -r --no-merged | grep -v HEAD); do echo -e "$(git show --format='%ci %cr %an' ${branch} | head -n 1) \t${branch}"; done | sort -r
}

# vim: ft=sh
