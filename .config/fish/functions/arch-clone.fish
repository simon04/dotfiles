function arch-clone --description 'Clones the Arch package source as Git repository' --argument-names pkg
    git clone --single-branch --branch packages/$pkg https://git.archlinux.org/svntogit/packages.git $pkg
    or git clone --single-branch --branch packages/$pkg https://git.archlinux.org/svntogit/community.git $pkg
    and cd $pkg
end
