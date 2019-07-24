#
# setup bash environment vars
#


# History
#

HISTCONTROL=ignoreboth

HISTSIZE=1000
HISTFILESIZE=2000



# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
