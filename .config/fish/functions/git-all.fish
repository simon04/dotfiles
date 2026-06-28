function git-all
    echo "Running 'git $argv' on all subdirectories..."
    /usr/bin/ls --directory */.git | \
        /usr/bin/xargs dirname | \
        /usr/bin/xargs --replace sh -c "echo; echo == {} ==; git --no-pager -C {} $argv"
end
