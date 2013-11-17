xset r rate 200 30
setxkbmap -layout "us, ru" -option "grp:caps_toggle,compose:ralt,terminate:ctrl_alt_bksp"
syndaemon -k -i 0.3 -d &

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

export SHELL=/usr/bin/zsh
export PATH=/home/$(whoami)/bin/:$PATH

exec i3
