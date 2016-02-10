~simon04
========

```
git clone --separate-git-dir=~/.dotfiles https://github.com/simon04/dotfiles.git ~
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config status.showUntrackedFiles no
```
