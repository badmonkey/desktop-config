#
# Setup for session
#


# setxkbmap -option "ctrl:swapcaps"
# setxkbmap -option "caps:hyper"
# setxkbmap -option "caps:super"


setxkbmap -option "caps:ctrl_modifier"
xmodmap -e "keysym Menu = Caps_Lock"



function space2ctrl {
	spare_modifier = $1

	xmodmap -e "keysym space = $spare_modifier"
	xmodmap -e "remove mod4 = $spare_modifier" # hyper_l is mod4 by default
	xmodmap -e "add Control = $spare_modifier"

	xmodmap -e "keycode any = space"

	xcape -t 500 -e "$spare_modifier=space"
}

# space2xtrl "Hyper_L"



export BASH_SESSION_START=1
