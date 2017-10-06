set lines=40
set columns=120

set cursorline

source ~/.vimrc

if has('unix')
  colorscheme slate
  set guifont=Noto\ Mono\ 12
  set linespace=1
endif

if has('win32')
  colorscheme desert
  set guifont=Consolas:h11
  set linespace=1
  " for CTRL-X, CTRL-C and CTRL-V
  source $VIMRUNTIME/mswin.vim
endif
