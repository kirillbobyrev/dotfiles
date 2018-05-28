#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Custom variables
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
PATH="/home/kbobyrev/.cargo/bin:$PATH"
