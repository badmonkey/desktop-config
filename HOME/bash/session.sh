#
# Setup for session
#


#setxkbmap -option "caps:hyper"
# caps:super


spare_modifier="Hyper_L"

xmodmap -e "keycode 65 = $spare_modifier"
xmodmap -e "remove mod4 = $spare_modifier" # hyper_l is mod4 by default
xmodmap -e "add Control = $spare_modifier"

xmodmap -e "keycode any = space"

xcape -t 400 -e "$spare_modifier=space"



export BASH_SESSION_START=1
