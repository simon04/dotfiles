function aur-clone --description 'Clones the AUR package source as Git repository' --argument-names pkg
    git clone ssh+git://aur@aur.archlinux.org/$pkg.git
    or git clone https://aur.archlinux.org/$pkg.git
    and cd $pkg
end
