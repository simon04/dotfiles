function git --description 'git wrapper: treat main/master as interchangeable per repo'
    # Only rewrite when inside a git repository.
    if command git rev-parse --git-dir >/dev/null 2>&1
        set -l canonical (__git_canonical_default)
        if test -n "$canonical"
            # The name we rewrite *away from* is the other one.
            set -l other master
            test "$canonical" = master; and set other main

            set -l newargs
            for a in $argv
                switch $a
                    case $other
                        # Bare branch name: master -> main (or vice versa).
                        set -a newargs $canonical
                    case "*/$other"
                        # Qualified ref: origin/master, refs/heads/master, etc.
                        set -a newargs (string replace -r -- '/'$other'$' "/$canonical" $a)
                    case '*'
                        set -a newargs $a
                end
            end
            command git $newargs
            return $status
        end
    end
    command git $argv
    return $status
end
