#!/bin/sh
if [[ $(netctl is-active wlp58s0-OEBB) = active ]]; then
  echo -n "railjet: "
  curl --silent http://railnet.oebb.at/api/speed
  echo " km/h"
fi
