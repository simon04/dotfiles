#!/bin/sh

cat $HOME/.vim/config/*.vim $HOME/.vimrc | grep --invert-match --ignore-case --extended-regexp '[bv]undle' > /tmp/_vimrc
cat $HOME/.gvimrc | grep --invert-match 'vimrc$' > /tmp/_gvimrc
