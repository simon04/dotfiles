#!/bin/sh

if [[ -x /usr/bin/parcellite ]]; then
  pidof parcellite || exec parcellite &
elif [[ -x /usr/bin/copyq ]]; then
  pidof copyq || exec copyq &
elif [[ -x /usr/bin/clipit ]]; then
  pidof clipit || exec clipit &
fi
