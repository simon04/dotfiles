#!/bin/bash

export $(dbus-launch)

for f in ~/.xinitrc.d/*.sh ; do
	[ -x "$f" ] && . "$f"
done

# load local settings
~/.xinitrc.local

exec ${1:-i3}
