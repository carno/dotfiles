# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

shopt -s checkwinsize

shopt -s histappend

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;[${HOSTNAME}][${PWD/#$HOME/~}]\007";'
    ;;
*)
    ;;
esac

export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# for my eyes only
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

# bash completion for todo.txt
if [ -f ~/dokumenty/github/todo.txt-cli/todo_completion ]; then
    source ~/dokumenty/github/todo.txt-cli/todo_completion
    complete -F _todo t
fi

# pimp my prompt
PS1='[\A][\w](\j)$(__git_ps1 "(%s)")\$ '

# history settings
HISTIGNORE="&:la:ls:ll:c:q"
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
export HISTCONTROL=erasedups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# limit man display width
export MANWIDTH=96

# pimp my PATH
export PATH=$HOME/dokumenty/github/todo.txt-cli:$PATH

# default action for todo.txt
export TODOTXT_DEFAULT_ACTION=ls

# vimgpg
export GPG_TTY=`tty`

# virtualenvwrapper
export WORKON_HOME=$HOME/envs

# vim: ft=sh
