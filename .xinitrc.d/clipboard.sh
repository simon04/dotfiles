#!/bin/sh

if [[ -x /usr/bin/parcellite ]]; then
  pid parcellite || exec parcellite &
elif [[ -x /usr/bin/copyq ]]; then
  pid copyq || exec copyq &
elif [[ -x /usr/bin/clipit ]]; then
  pidof clipit || exec clipit &
fi
