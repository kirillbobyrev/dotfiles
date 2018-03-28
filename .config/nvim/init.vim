set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
" TODO(omtcvxyz): Put this into ~/.vimrc. Find out which plugin messes up with
" guicursor and stop using it.
set guicursor=
