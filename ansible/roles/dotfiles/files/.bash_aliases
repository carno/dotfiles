# shellcheck shell=bash

# basic aliases
alias ..='cd ..'
alias c='[ $[$RANDOM % 10] = 0 ] && timeout 3 cmatrix; clear || clear'
alias cp='cp -v'
if [[ -x "$(command -v eza)" ]]; then
    alias l='eza --group --group-directories-first --icons --long'
    alias ll='l'
    alias la='ll --all'
    alias tree='eza --tree --level=2 --long --icons --git'
    # fix invisible punctuation
    export EZA_COLORS="xx=38;5;240"
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

function ,venv() {
    # if no python version provided, list available python versions
    if [[ $# -ne 1 ]]; then
        pyenv versions --skip-aliases --skip-envs
    else
        local python_version="${1}"
        pyenv virtualenv "${python_version}" "$(basename $(pwd))"
        pyenv local "$(basename $(pwd))"
    fi
}

# vim: ft=sh
