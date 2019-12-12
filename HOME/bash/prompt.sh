#
# set up bash prompt
#


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
else
	color_prompt=
fi


if [ "$color_prompt" = yes ]; then
	if [ $(id -u) -eq 0 ]; then
		PRMPT_HOST='\[\e[01;31m\]\u@\h\[\e[00m\]'
	else
		PRMPT_HOST='\[\e[01;32m\]\u@\h\[\e[00m\]'
	fi
	PRMPT_HOST="${PRMPT_HOST}:\[\e[01;36m\]\$(work-dir)\[\e[00m\]"
else
    PRMPT_HOST='\u@\h:\w'
fi
unset color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PRMPT_HOST="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]${PRMPT_HOST}"
    ;;
*)
    ;;
esac



SSH_IP=$(echo "$SSH_CLIENT" | cut -d' ' -f 1)
if [ "$SSH_IP" != "" ]; then
	SSH_PROMPT="ssh:\[\e[1;33m\]${SSH_IP}\[\e[0m\]|"
else
	SSH_PROMPT=""
fi

if [ "$debian_chroot" != "" ] ; then
	CHROOT_PROMPT="chroot:\[\e[1;31m\]${debian_chroot}\[\e[0m\]|"
else
	CHROOT_PROMPT=""
fi



optional-line() {
	TMP="${CHROOT_PROMPT}${SSH_PROMPT}"
	if [ "$TMP" != "" ]; then
		echo "\n| [${TMP}]"
	else
		echo ""
	fi
}


RET_PROMPT='[${GIT_PROMPT_LAST_COMMAND_STATE}]'


# append git status
#PS1="${PS1} \[\e[1;33m\]\$(git-prompt)\[\e[0m\]"

GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_START="┌─[\[\e[1;31m\]\$(virtual-env-name)\[\e[0m\]] [${PRMPT_HOST}]"

# working prompt
GIT_PROMPT_END="\n└─[${CHROOT_PROMPT}${SSH_PROMPT}stack:\[\e[1;33m\]\$(dirstack-top)\[\e[0m\]]${RET_PROMPT} \[\e[1;31m\]λ\[\e[0m\] "

#
# λ  ❱  ▶  ⊳  △  ▲  ▽  ▼  ⬡  ⬢
#

source ~/.bash-git-prompt/gitprompt.sh
