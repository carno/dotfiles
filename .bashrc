# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Update window size after every command
shopt -s checkwinsize
# Append to the history file, don't overwrite it
shopt -s histappend

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

unset PROMPT_COMMAND
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;[${HOSTNAME}][${PWD/#$HOME/~}]\007";'
    ;;
*)
    ;;
esac
export PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"

# .local/bin (pip --user etc)
export PATH=${HOME}/.local/bin:${PATH}

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# for my eyes only
if [ -f ~/.local_bash ]; then
    . ~/.local_bash
fi
if [ -f ~/.local_aliases ]; then
    . ~/.local_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# history settings
HISTIGNORE="&:la:ls:ll:c:q:fg:w"
HISTTIMEFORMAT='[%d/%m %H:%M] '
HISTSIZE=10000
HISTFILESIZE=10000

# less colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS='-C -M -I -j 10 -# 4'

# 256 colors
# export TERM=xterm-256color

# don't put duplicate lines in the history. See bash(1) for more options
# ... and ignore same sucessive entries.
export HISTCONTROL="erasedups:ignoreboth"

# limit man display width
export MANWIDTH=96

# use vim for man pager
export MANPAGER="vim -M +MANPAGER -"

# vimgpg
export GPG_TTY=$(tty)

# virtualenvwrapper
if [[ -f /usr/local/bin/virtualenvwrapper.sh ]]; then
    . /usr/local/bin/virtualenvwrapper.sh 2>/dev/null
fi
export WORKON_HOME=${HOME}/.envs

# last but not least, let's go Vim
set -o vi

# enable fzf
if [[ -f ~/.fzf.bash ]]; then
    . ~/.fzf.bash
    if [[ -x "$(command -v rg)"  ]]; then
        export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
        export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
    fi
    if [[ -x "$(command -v fdfind)" ]]; then
        export FZF_ALT_C_COMMAND='fdfind --type d --hidden --follow'
    fi
fi

if [[ -x "$(command -v kubectl)" ]]; then
    source <(kubectl completion bash)
    alias k=kubectl
    complete -F __start_kubectl k
fi

if [[ -x "$(command -v terraform)" ]]; then
    complete -C terraform terraform
fi

if [[ -x "$(command -v helm)" ]]; then
    source <(helm completion bash)
fi

if [[ -x "$(command -v yq)" ]]; then
    source <(yq shell-completion bash)
fi

if [[ -d ~/.krew/bin ]]; then
    export PATH=${HOME}/.krew/bin:${PATH}
fi

if [[ -x "$(command -v fortune)" ]]; then
    echo -e "$(fortune -a -s)\n"
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte-2.91.sh
fi

if [[ -x "$(command -v starship)" ]]; then
    eval "$(starship init bash)"
else
    # git-prompt
    if [ -f /usr/lib/git-core/git-sh-prompt ]; then
        . /usr/lib/git-core/git-sh-prompt
    fi

    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    # Explicitly unset color (default anyhow). Use 1 to set it.
    GIT_PS1_SHOWCOLORHINTS=
    GIT_PS1_DESCRIBE_STYLE="branch"
    GIT_PS1_SHOWUPSTREAM="auto git"

    # pimp my prompt
    PS1='\A | \u@\h | \w | $(__git_ps1 " %s | ")${PIPESTATUS[@]}\n(\j) \$ '
fi

# vim: ft=sh
