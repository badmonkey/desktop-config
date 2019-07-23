#
# setup top level login shell
#


# keyboard setup
#

# setxkbmap -option "caps:hyper"

spare_modifier="Hyper_L"

xmodmap -e "keycode 65 = $spare_modifier"
xmodmap -e "remove mod4 = $spare_modifier" # hyper_l is mod4 by default
xmodmap -e "add Control = $spare_modifier"
xmodmap -e "keycode any = space"

xcape -e "$spare_modifier=space"
