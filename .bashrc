#!/bin/bash
#set -x
# .bashrc

if ! tty &>/dev/null; then
	return
fi

#Set color
export TERM=xterm-256color

#start tmux session
if [ command -v tmux >/dev/null 2>&1 ]; then
  echo "tmux not found on this machine"
else
  if [ -z "$TMUX" ]; then
    if [ -z  "$(tmux list-sessions 2>/dev/null)" ]; then
      exec tmux new-session
    else
      exec tmux attach
    fi
    unbind -a
  fi
fi

# update ssh agent socket
SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" ] && [ -x "$SSHAGENT" ]; then
  eval $($SSHAGENT $SSHAGENTARGS) >/dev/null
  trap "kill $SSH_AGENT_PID" 0
fi
# load Fuzzy finder if present
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#load rsa key
ssh-add 2>/dev/null
ssh-add ~/.ssh/*rsa 2>/dev/null

# User specific aliases and functions
alias rm='rm -I'
alias lsf="ls -l | grep -v '^d'" #list only files
alias lsd='ls -d */' #list only directories
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias refresh='export $(tmux show-environment SSH_AUTH_SOCK)'
alias today='date +%F'
alias yesterday='date --date yesterday +%F'
alias ll='ls -lrth'
alias vimdiff='vim -d'

#Extract a archive file based on its extension
extract () {
   if [ -f "$1" ] ; then
       case "$1" in
           *.tar.bz2)   tar xvjf "$1"    ;;
           *.tar.gz)    tar xvzf "$1"    ;;
           *.bz2)       bunzip2 "$1"     ;;
           *.rar)       unrar x "$1"     ;;
           *.gz)        gunzip "$1"      ;;
           *.tar)       tar xvf "$1":    ;;
           *.tbz2)      tar xvjf "$1"    ;;
           *.tgz)       tar xvzf "$1"    ;;
           *.zip)       unzip "$1"       ;;
           *.Z)         uncompress "$1"  ;;
           *.7z)        7za x "$1"       ;;
           *)           echo "Oops.. Don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s autocd
shopt -s cdspell
shopt -s cmdhist
shopt -s direxpand
shopt -s dirspell
shopt -s dotglob
shopt -s histreedit
shopt -s hostcomplete
shopt -s nocaseglob

# History search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind 'set show-all-if-ambiguous on'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# local RPM repository maintenance funcions
if [ -f ~/.localrpm ]; then
	. ~/.localrpm
fi

umask 0022
export el5=centos-5-i386
export el7=centos-7-x86_64

#customised PS1 prompt to change color based on exit code of last executed command.
trap 'PREVIOUS_COMMAND=$THIS_COMMAND; THIS_COMMAND=$BASH_COMMAND' DEBUG
read -r -d '' PROMPT_COMMAND <<'END'
    if [ $? = 0 -o $? == 130 -o "$PREVIOUS_COMMAND" == ": noop" ]; then
        PS1='\[\033[0;33m\][\!]\[\e[32;1m\]\u\[\e[0m\]:[suseT]\[\e[34;1m\]\w\[\e[0m\]$ '
    else
        PS1='\[\033[0;33m\][\!]\[\e[31;1m\]\u\[\e[31;1m\]:[suseT]\[\e[34;1m\]\w\[\e[0m\]$ '
    fi
    : noop
END

# proxy
#pw=""
#ur=""
#export http_proxy="http://$ur:$pw@:8080"
#export https_proxy="$http_proxy"
#export ftp_proxy="$http_proxy"
#export all_proxy="$http_proxy"
#export no_proxy=domain.com
#export RSYNC_PROXY="$ur:$pw@"
#unset pw
#unset ur

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/suresh/.sdkman"
[[ -s "/home/suresh/.sdkman/bin/sdkman-init.sh" ]] && source "/home/azzhangc/.sdkman/bin/sdkman-init.sh"


