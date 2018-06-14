#!/bin/sh

setxkbmap -layout us -variant altgr-intl
xmodmap ~/.Xmodmap

if [[ -x /usr/bin/numlockx ]]; then
  numlockx on
fi
