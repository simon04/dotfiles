source /etc/profile
source ~/.shrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=erasedups

PS1='\n[\t][\u@\h \W]\n\$ '

_shopt () {
  shopt -s $1 2> /dev/null
}
_shopt cmdhist
_shopt histappend
_shopt hostcomplete
_shopt globstar # http://www.bash-hackers.org/wiki/doku.php/syntax/expansion/globs
set -o notify # notify of bg job completion immediately

# Battery charge as a percentage.
bchrg() {
  now=`cat /sys/class/power_supply/BAT0/energy_now`
  full=`cat /sys/class/power_supply/BAT0/energy_full`
  out=`echo $now/$full*100 | bc -l | cut -c 1-5`
  echo "Charge: "$out"%"
}

# Battery capacity as a percentage.
bcap() {
  design=`cat /sys/class/power_supply/BAT0/energy_full_design`
  current=`cat /sys/class/power_supply/BAT0/energy_full`
  out=`echo $current/$design*100 | bc -l | cut -c 1-5`
  echo "Capacity: "$out"%"
}

