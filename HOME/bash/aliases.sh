#
# setup aliases for interactive shell
#

alias pyack='ack --type=python'


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# some `ls` aliases
alias ll='ls -halF'
alias la='ls -A'
alias l='ls -CF'

alias rless='less -R'

alias rm=trash

# fast cd, adds `z` cd-like command
eval "$(fasd --init auto)"


function select-one {
    if [ -z "$1" ]; then
	echo ""
    elif [ $(wc -l <<< "$1") -eq 1 ]; then
	echo "$1"
    else
	echo "$1" | fzf-tmux -p
    fi
}

unalias zz
function zz {
    choices=$(fasd -d -R -l "$1")
    target=$(select-one "$choices")
    if [ ! -z "$target" ]; then
	fasd_cd -d "$target"
    fi
}


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
