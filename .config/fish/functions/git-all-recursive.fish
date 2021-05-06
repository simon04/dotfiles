function git-all-recursive
    echo "Running 'git $argv' recursively on all subdirectories..."
    find -name .git | \
        xargs dirname | \
        xargs --replace sh -c "echo; echo == {} ==; git -C {} $argv"
end
