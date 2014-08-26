. /etc/profile

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# override and disable tilde expansion
_expand () {
    return 0
}

export PATH="$PATH:/sbin:$HOME/bin"
export EDITOR='vim'
export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=erasedups
export CVS_RSH=ssh

#export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:'

alias autorotate='jhead -autorot'
alias df='df -h'
alias diff='diff -u'
alias f='find | grep'
alias grep='grep --color'
alias ls='ls --color=auto'
alias l='ls -l'
alias lt='ls -trl'
alias sps="ps -ef | grep -v grep | grep"
alias svndiff='svn diff -x -w | vim -R -'
alias cvsdiff='cvs diff -w -U 2 | grep --invert-match ^? | vim -R -'
alias vless='vim - -R'
alias wgeto='wget -qO -'
alias youtube-dl='youtube-dl -t'
alias ocaml='rlwrap ocaml'
alias sudo='sudo -E'
alias rubber='rubber --pdf'
alias pl='pdflatex -interaction=nonstopmode'
alias q!='unset HISTFILE && exit'
alias p0='patch -p0'
alias p1='patch -p1'

#params: [in] [out.ext]
extract_audio () {
  ffmpeg -i "$1" -vn -acodec copy "$2"
}

#PS1='\n[\t][\u@\h \W]\n\$ '

_shopt () {
  shopt -s $1 2> /dev/null
}
_shopt cmdhist
_shopt histappend
_shopt hostcomplete
_shopt globstar # http://www.bash-hackers.org/wiki/doku.php/syntax/expansion/globs
set -o notify # notify of bg job completion immediately

# Allow wget download from http://trailers.apple.com/
alias wget_apple='wget -U "QuickTime/7.6.2"'

#export _JAVA_OPTIONS=-Dswing.defaultlaf=javax.swing.plaf.metal.MetalLookAndFeel

mkcd () {
  mkdir -p "$@" && cd "$_"
}

# Disable the touchpad while typing
#syndaemon -k -i 2 -d &

# Print command that I always forget
helpme () {
  cat <<EOF
  exiftool -AllDates-=1:08 -overwrite_original .
  exiftool '-DateTimeOriginal>FileModifyDate' -overwrite_original .
  exiftool -Author='Simon Legner, 2012' '-DateTimeOriginal>FileModifyDate' -overwrite_original .
  exiftool -r '-FileName<DateTimeOriginal' -d IMG_%Y%m%d_%H%M%S.%%e .
  exiftool -d '%Y-%m-%d_%H:%M:%S_%%f.%%e' '-FileName<DateTimeOriginal' .
  scanimage -L
  scanimage -d genesys:libusb:001:009 -p --resolution 150
  chromium --incognito --proxy-pac-url=~/.config/proxy.pac
  date -d @1319009864
  cat src | while read line; do ...; done
  2>&1
  readlink -f
EOF
}

# remindme - a simple reminder
# usage: remindme 10m "omg, the pizza"
remindme () {
  sleep $1 && zenity --info --text "$2" &
}

# x - archive extractor
# usage: x <file>
x () {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2) tar xjf "$1"    ;;
      *.tar.gz)  tar xzf "$1"    ;;
      *.bz2)     bunzip2 "$1"    ;;
      *.rar)     unrar x "$1"      ;;
      *.gz)      gunzip "$1"     ;;
      *.tar)     tar xf "$1"     ;;
      *.tbz2)    tar xjf "$1"    ;;
      *.tgz)     tar xzf "$1"    ;;
      *.jar)     unzip "$1"      ;;
      *.zip)     unzip "$1"      ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7z x "$1"       ;;
      *)         echo "'$1' cannot be extracted via x ()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# If available, use dtrx: Intelligent archive extraction http://brettcsmith.org/2007/dtrx/
which dtrx 2> /dev/null > /dev/null && alias x=dtrx

# from: https://bitbucket.org/andrewgodwin/tildebin/src/336b897c07d0/bashrc
# Picks a random colour based on the hostname.
color_from_hostname () {
  hash=`(echo $USER; hostname) | md5sum | awk '{print $1}'`
  case ${hash#${hash%?}} in
  "0") c="1" ;; # red
  "1") c="1" ;; # red
  "2") c="2" ;; # green
  "3") c="2" ;; # green
  "4") c="4" ;; # blue
  "5") c="4" ;; # blue
  "6") c="6" ;; # cyan
  "7") c="6" ;; # cyan
  "8") c="5" ;; # purple
  "9") c="5" ;; # purple
  "a") c="3" ;; # yellow
  "b") c="3" ;; # yellow
  "c") c="1" ;; # red
  "d") c="5" ;; # purple
  "e") c="4" ;; # blue
  "f") c="6" ;; # cyan
  esac
  echo $c
}

# Construct PS1 prompt
function _ps1 () {
  _EXIT=$? # must be first command
  std="\[\e[0m\]"
  _EXIT="\[\e[47m\]\[\e[1;30m\] $_EXIT $std"
  _TIME="\[\e[40m\]\[\e[1;37m\] \t $std"
  _HOST="\[\e[4`color_from_hostname`m\]\[\e[1;37m\] \h $std"
  _USER="\[\e[40m\]\[\e[1;37m\] \u $std"
  _WD="\[\e[47m\]\[\e[1;30m\] \w $std"
  _JOBS=$(jobs | wc -l)
  [ $_JOBS -gt 0 ] && _JOBS="jobs:$_JOBS " || _JOBS=''
  _SCM='\[\e[1;37m\]\[\e[42m\] '$_JOBS'`_show_scm_repo`'$std
  #SCM='\[\e[1;37m\]\[\e[42m\] `_parse_cvs``_parse_svn_branch``_parse_hg_branch``_parse_git_branch``_virtualenvname`'$std
  _PROMT="\[\e[1;37m\]\[\e[42m\] > $std"
  export PS1="\n$_EXIT$_TIME$_HOST$_USER$_WD$_SCM\n$_PROMT "
}
PROMPT_COMMAND=_ps1

_show_scm_repo () {
  [ -d .git ] && echo -n 'git '
  [ -d .hg ] && echo -n 'hg '
  [ -d .svn ] && echo -n 'svn '
  [ -d CVS ] && echo -n 'cvs '
}

# VCS functions
_parse_git_branch () {
  if [ -d ".git" ]; then
    branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    url=$(git config --get remote.origin.url)
    if [ -n "$url" ]; then
      url=$(basename $url)
    else
      url='git'
    fi
    echo "$url:$branch "
  fi
}
_parse_svn_branch () {
  if [ -d ".svn" ]; then
    svn info 2> /dev/null | grep -e '^URL*' | sed -e 's#.*/\(.*\)#svn:\1 #g'
  fi
}
_parse_hg_branch () {
  if [ -d ".hg" ]; then
    hg branch 2> /dev/null | sed 's#\(.*\)#hg:\1 #'
  fi
}
_parse_cvs () {
  [ -d 'CVS' ] && echo 'cvs: '
}
_virtualenvname () {
  if [ `echo $VIRTUAL_ENV` ]; then
    echo -n "ve:`basename $VIRTUAL_ENV` "
  fi
}

cdd () {
  case $(/bin/ls|grep $@|wc -l) in
    1)
      d=$(/bin/ls|grep $@)
      echo "cd \"$d\""
      cd "$d"
      ;;
    0)
      echo "No match for $@."
      ;;
    *)
      echo "Too many matches for $@:"
      /bin/ls|grep $@
      ;;
  esac
}

focallengthplot () {
  exiftool -T -filename -focallength "$@" | sort -u | awk -F "\t" '{print ($2-$2%5)"-"($2+4-$2%5)}' | sort -n | uniq -c | awk 's=""; {while (length(s)<$1) s=s"*"; printf "%8s "mm"  [%4d]  %s\n", $2, $1, s}'
  exiftool -T -filename -focallength "$@" | sort -u | awk -F "\t" '{print $2}' | sort -n | uniq -c | awk 's=""; {while (length(s)<$1) s=s"*"; printf "%8s "mm"  [%4d]  %s\n", $2, $1, s}'
}

# `d 1` rembers current directory for quick returning with `1`
d() {
  alias $1="cd $PWD"
}

# shortcut for launching zathura, a PDF viewer
z() {
  [ -f "$1" ] && (zathura "$@" > /dev/null 2>&1 & disown)
  [ -f "$1" ] || (echo "File '$1' does not exist")
}
complete -f -o plusdirs -X '!*.[pf]df' z

# load local settings
[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local

alias cleanlatex='rm -f *.{aux,log,nav,out,snm,toc,vrb,dvi,*latexmk}'
alias cleanshp='rm -f *.{cpg,dbf,prj,shp,shx}'

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

dataurl() {
  # src: http://nick.zoic.org/art/etc/make-data-url.html
  for filename; do
    mimetype=`file -b --mime-type $filename`
    encoded=`base64 -w 0 $filename`
    echo "data:$mimetype;base64,$encoded"
  done
}

mpd_pause_after_current_track() {
  # src: https://bbs.archlinux.org/viewtopic.php?id=55884
  sleep $(mpc | awk -F"[ /:]" '/playing/ {print 60*($8-$6)+$9-$7}');mpc pause
}

httpd_py () {
  python2 -m SimpleHTTPServer ${1:-8000}
}

httpd_php () {
  php -S localhost:${1:-8000}
}

prepend_date () {
  for i in "$@"; do mv -v "$i" "$(date -I) $i"; done
}
