. /etc/profile
#. /etc/bash_completion

# override and disable tilde expansion
_expand () {
    return 0
}

export PATH="$PATH:/sbin:$HOME/bin"
export EDITOR='vim'
export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth # ingore duplicates and spaces (ignoreboth, ignoredups, ignorespace)
export CVS_RSH=ssh

#export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:'

# Check for an interactive session
[ -z "$PS1" ] && return

alias autorotate='jhead -autorot'
alias cdt='cd /tmp/'
alias df='df -h'
alias diff='diff -u'
alias f='find | grep'
alias grep='grep --color'
alias ls='ls --color=auto -1 -F'
alias sps="ps -ef | grep -v grep | grep"
alias svndiff='svn diff -x -w | vim -R -'
alias updategit='packer -S `pacman -Qsq|grep '\-git$'` --noconfirm'
alias vless='vim - -R'
alias wgeto='wget -qO -'
alias youtube-dl='youtube-dl -t'

#PS1='\n[\t][\u@\h \W]\$ '
#PS1='\n[\t][\u@\h] \w\n\$ '
PS1='\n[\t][\u@\h \W]\n\$ '

# http://stick.gk2.sk/blog/2011/06/ps1-tricks/
#export GIT_PS1_SHOWDIRTYSTATE=1
#export GIT_PS1_SHOWSTASHSTATE=1
#export GIT_PS1_SHOWUNTRACKEDFILES=1
#export PS1='\[\033[1;37m\][\[\033[1;32m\]\u\[\033[0m\]@\h\[\033[0m\] $? \[\033[1;34m\]\w\[\033[0;35m\]$(__git_ps1 " %s")\[\033[1;37m\]]\[\033[0m\] '

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
  mkdir $1 && cd $1
}

# Disable the touchpad while typing
#syndaemon -k -i 2 -d &

# Print command that I always forget
helpme () {
  cat <<EOF
  exiftool -AllDates-=1:08 ./path/to/directory
  exiftool '-DateTimeOriginal>FileModifyDate' ./path/to/directory
  exiftool -Author='Simon Legner, 2011' '-DateTimeOriginal>FileModifyDate' ./path/to/directory
  scanimage -L
  scanimage -d genesys:libusb:001:009 -p --resolution 150
  chromium --incognito --proxy-pac-url=~/.config/proxy.pac
EOF
}

# from: http://cinderwick.ca/files/configs/bashrc
pacsearch () {
  echo -e "$(pacman -Ss $@ | sed \
    -e 's#core/.*#\\033[1;31m&\\033[0;37m#g' \
    -e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
    -e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
    -e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' )"
}

# remindme - a simple reminder
# usage: remindme 10m "omg, the pizza"
remindme () {
  sleep $1 && zenity --info --text "$2" &
}

# x - archive extractor
# usage: x <file>
x () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       rar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via x ()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

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

# Customised prompt; shows svn/git/hg status too
#PS1='\[\e[4`color_from_hostname`m\]\[\e[1;37m\] \h \[\e[40m\]\[\e[1;37m\] \u \[\e[47m\]\[\e[1;30m\] \w \[\e[0m\]\[\e[1;37m\]\[\e[42m\] `parse_svn_branch``parse_hg_branch``parse_git_branch``virtualenvname`> \[\e[0m\] '
PS1='\n\[\e[40m\]\[\e[1;37m\] \t \[\e[4`color_from_hostname`m\]\[\e[1;37m\] \h \[\e[40m\]\[\e[1;37m\] \u \[\e[47m\]\[\e[1;30m\] \w \[\e[0m\]\[\e[1;37m\]\[\e[42m\] `parse_cvs``parse_svn_branch``parse_hg_branch``parse_git_branch``virtualenvname`\[\e[0m\]\n\[\e[1;37m\]\[\e[42m\] > \[\e[0m\] '

# VCS functions
parse_git_branch () {
  if [ -d ".git" ]; then
    git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)#git:\1 #'
  fi
}
parse_svn_branch () {
  if [ -d ".svn" ]; then
    parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "svn:"$1 "" $2 " "}'
  fi
}
parse_svn_url () {
  svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
parse_svn_repository_root () {
  svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}
parse_hg_branch () {
  if [ -d ".hg" ]; then
    hg branch 2> /dev/null | sed 's#\(.*\)#hg:\1 #'
  fi
}
parse_cvs () {
  [ -d 'CVS' ] && echo 'cvs: '
}
virtualenvname () {
  if [ `echo $VIRTUAL_ENV` ]; then
    echo -n "ve:`basename $VIRTUAL_ENV` "
  fi
}

