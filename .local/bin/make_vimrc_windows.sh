#!/bin/sh

cat $HOME/.vim/config/*.vim $HOME/.vimrc | grep --invert-match --ignore-case --extended-regexp 'plug[ #]' > /tmp/_vimrc
cat $HOME/.gvimrc | grep --invert-match 'vimrc$' > /tmp/_gvimrc
ls -l /tmp/_vimrc /tmp/_gvimrc
