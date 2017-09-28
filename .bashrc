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

