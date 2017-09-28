function dotfiles --wraps git --description '~simon04'
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
end
