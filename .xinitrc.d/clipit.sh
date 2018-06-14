#!/bin/sh

if [[ -x /usr/bin/clipit ]]; then
  pidof clipit || exec clipit &
fi
