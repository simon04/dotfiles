function dotfiles --wraps git --description '~simon04'
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
end
