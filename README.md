~simon04
========

```
git clone --separate-git-dir=~/.dotfiles https://github.com/simon04/dotfiles.git ~
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no
```
