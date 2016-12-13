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
PS1='[\A][\h][\w](\j)$(__git_ps1 "(%s)")\$ '

# history settings
HISTIGNORE="&:la:ls:ll:c:q:fg:w"
HISTTIMEFORMAT='[%d/%m %H:%M] '
HISTSIZE=10000
HISTFILESIZE=10000

# colorful man
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# 256 colors
# export TERM=xterm-256color

# don't put duplicate lines in the history. See bash(1) for more options
# ... and ignore same sucessive entries.
export HISTCONTROL="erasedups:ignoreboth"

# limit man display width
export MANWIDTH=96

# vimgpg
export GPG_TTY=$(tty)

# virtualenvwrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi
export WORKON_HOME=${HOME}/envs

# last but not least, let's go Vim
set -o vi

if [ -x /usr/games/fortune ]; then
    fortune -s
    echo
fi

# enable fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# vim: ft=sh
