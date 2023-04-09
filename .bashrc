#!/bin/bash
#set -x
# .bashrc
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export FONT="Hack"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# use nvim to open manpages
export MANPAGER='nvim +Man!'
export MANWIDTH=999

if ! tty &>/dev/null; then
	return
fi

# Set color
export TERM=screen-256color
set termguicolors

# start tmux session automatically or attach to existing session
function manage_tmux() {
	if ! command -v tmux >/dev/null 2>&1; then
		echo "tmux not found on this machine"
	else
		if [ -z "$TMUX" ]; then
			if [ -z "$(tmux list-sessions 2>/dev/null)" ]; then
				exec tmux new-session
			else
				exec tmux attach
			fi
			unbind -a
		fi
	fi
}

# Change window color to red when connecting to remote
function sshTmuxColor() {
	if [ -n "$TMUX" ]; then
		case "$1" in
		suresh*)
			tmux set-option -g window-status-current-style bg=green
			# tmux selectp -P 'fg=white,bg=colour22' #colour124=darker-green
			;;
		*)
			tmux set-option -g window-status-current-style bg=red
			tmux selectp -P 'fg=white,bg=colour52' # color28=darker-red
			;;
		esac
	fi
	ssh "$@"
	tmux selectp -P default
}

alias ssh=sshTmuxColor

# update ssh agent socket
SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" ] && [ -x "$SSHAGENT" ]; then
	eval "$($SSHAGENT $SSHAGENTARGS)" >/dev/null
	trap 'kill $SSH_AGENT_PID' 0
fi
# load Fuzzy finder if present
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#load rsa key
ssh-add 2>/dev/null
ssh-add ~/.ssh/*rsa 2>/dev/null

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias lsd='exa -lhDF'                #list only directories
alias lsf="ls -lArth | grep -v '^d'" #list only files
alias ll='exa -lhaFsmodified'        # use exa instead of ls
alias ..='cd ..'
alias refresh='export $(tmux show-environment SSH_AUTH_SOCK)'
alias today='date +%F'
alias yesterday='date --date yesterday +%F'
alias vimdiff='nvim -d'
alias vim='nvim'
alias passwd-generate="python3 -c \"import string,random; print (''.join(random.sample(string.punctuation+string.ascii_lowercase+string.ascii_uppercase+string.digits, 14)))\""

# Eazy navigation across directories
function up() {
	local d=""
	local limit="$1"

	# Default to limit of 1
	if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
		limit=1
	fi

	for ((i = 1; i <= limit; i++)); do
		d="../$d"
	done

	# perform cd. Show error if cd fails
	if ! cd "$d"; then
		echo "Couldn't go up $limit dirs."
	fi
}

#Extract a archive file based on its extension
# usage extract <file>
function extract() {
	if [ -f "$1" ]; then
		case "$1" in
		*.tar.bz2) tar xvjf "$1" ;;
		*.tar.gz) tar xvzf "$1" ;;
		*.bz2) bunzip2 "$1" ;;
		*.rar) unrar x "$1" ;;
		*.gz) gunzip "$1" ;;
		*.tar) tar xvf "$1": ;;
		*.tbz2) tar xvjf "$1" ;;
		*.tgz) tar xvzf "$1" ;;
		*.zip) unzip "$1" ;;
		*.Z) uncompress "$1" ;;
		*.7z) 7za x "$1" ;;
		*) echo "Oops.. Don't know how to extract '$1'..." ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

shopt -s autocd       # change to the directory
shopt -s cdspell      # autorcorrects cd misspellings
shopt -s cmdhist      # save multiline commands in history as a single line
shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s expand_aliases
shopt -s direxpand
shopt -s dirspell
shopt -s dotglob
shopt -s histreedit
shopt -s hostcomplete
shopt -s nocaseglob

# ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# History search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind 'set show-all-if-ambiguous on'

# never truncate bash history file
HISTSIZE=100000
HISTFILESIZE=200000
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# always write a history line
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# append to the history file, don't overwrite it
shopt -s histappend

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# local RPM repository maintenance funcions
if [ -f ~/.localrpm ]; then
	. ~/.localrpm
fi

umask 0022
export el7=centos-7-x86_64

# customised PS1 prompt to change color based on exit code of last executed command.
customisePS1() {
	trap 'PREVIOUS_COMMAND=$THIS_COMMAND; THIS_COMMAND=$BASH_COMMAND' DEBUG
	read -r -d '' PROMPT_COMMAND <<'END'
    if [ $? = 0 -o $? == 130 -o "$PREVIOUS_COMMAND" == ": noop" ]; then
        PS1='\[\033[0;33m\][\!]\[\e[32;1m\]\u\[\e[0m\]:[suseT]\[\e[34;1m\]\w\[\e[0m\]$ '
    else
        PS1='\[\033[0;33m\][\!]\[\e[31;1m\]\u\[\e[31;1m\]:[suseT]\[\e[34;1m\]\w\[\e[0m\]$ '
    fi
    : noop
END
}

#proxy
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

# main
customisePS1
manage_tmux

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/suresh/.sdkman"
if [ -s "/home/suresh/.sdkman/bin/sdkman-init.sh" ]; then
	source "/home/suresh/.sdkman/bin/sdkman-init.sh"
fi
