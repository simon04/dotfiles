function git-all
    echo "Running 'git $argv' on all subdirectories..."
    ls --directory */.git | \
        xargs dirname | \
        xargs --replace sh -c "echo; echo == {} ==; git -C {} $argv"
end
