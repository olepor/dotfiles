# clear all mappings
setxkbmap -option ''
# assign return to control on press, return on release
xmodmap -e 'clear Lock'
xmodmap -e 'keycode 66 = Control_L'
xmodmap -e 'add Control = Control_L'
# make a fake escape key (so we can map it with xcape)
xmodmap -e 'keycode 999 = Escape'
xcape -e 'Control_L=Escape'

./retremap.sh
# depends xmodmap xcape
# https://github.com/alols/xcape
