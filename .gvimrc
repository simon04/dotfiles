set lines=40
set columns=120

source ~/.vimrc

if has('unix')
  set cursorline
  colorscheme molokai
  set guifont=Fira\ Code\ 11
  set linespace=1
endif

if has('win32')
  colorscheme slate
  set guifont=Consolas:h11
  set linespace=1
  " for CTRL-X, CTRL-C and CTRL-V
  source $VIMRUNTIME/mswin.vim
endif
