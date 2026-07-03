function __git_canonical_default --description 'Echo main or master, whichever this repo uses (empty if ambiguous/unknown)'
    # Prefer local branches as the source of truth.
    set -l local_main (command git show-ref --verify --quiet refs/heads/main; and echo 1)
    set -l local_master (command git show-ref --verify --quiet refs/heads/master; and echo 1)

    if test -n "$local_main" -a -z "$local_master"
        echo main
        return
    end
    if test -n "$local_master" -a -z "$local_main"
        echo master
        return
    end
    if test -n "$local_main" -a -n "$local_master"
        # Both exist locally: genuinely distinct branches -> never rewrite.
        return
    end

    # Neither exists locally: fall back to the remote-tracking refs.
    set -l remote_main (command git show-ref --verify --quiet refs/remotes/origin/main; and echo 1)
    set -l remote_master (command git show-ref --verify --quiet refs/remotes/origin/master; and echo 1)

    if test -n "$remote_main" -a -z "$remote_master"
        echo main
        return
    end
    if test -n "$remote_master" -a -z "$remote_main"
        echo master
        return
    end
    # Unknown or ambiguous -> caller leaves the args untouched.
end
