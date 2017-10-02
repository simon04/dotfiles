function aur-clone
    git clone ssh+git://aur@aur.archlinux.org/$argv[1].git
    and cd $argv[1]
end
