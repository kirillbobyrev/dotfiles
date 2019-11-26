#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# User-specific stuff
export VISUAL=nvim
export EDITOR="$VISUAL"

# Use qt5ct external configuration unless on KDE Plasma.
[ "$XDG_CURRENT_DESKTOP" = "KDE" ] || export QT_QPA_PLATFORMTHEME="qt5ct"
