#!/bin/sh
if [[ $(netctl is-active wlp58s0-OEBB) = active ]]; then
  echo -n "railjet: "
  curl --silent http://railnet.oebb.at/api/speed
  echo " km/h"
elif [[ $(netctl is-active wlp58s0-WIFIonICE) = active ]]; then
  echo "ice: $(curl --silent https://iceportal.de/api1/rs/status | jq .speed) km/h"
fi
