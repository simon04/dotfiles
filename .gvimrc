set lines=40
set columns=120

map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

"nmap <C-V> "+gP
"imap <C-V> <ESC><C-V>i
"imap <C-V> "+p
"nmap <C-V> i<C-V><ESC>
vmap <C-C> "+y

set cursorline

source ~/.vimrc

if has('unix')
  colorscheme molokai
  set guifont=Inconsolata\ 12
  set linespace=1
endif

if has('win32')
  colorscheme desert
  set guifont=Consolas:h11
  set linespace=1
endif
