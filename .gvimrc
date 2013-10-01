set lines=40
set columns=100

map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

"nmap <C-V> "+gP
"imap <C-V> <ESC><C-V>i
"imap <C-V> "+p
"nmap <C-V> i<C-V><ESC>
vmap <C-C> "+y

set cursorline

source ~/.vimrc

"colorscheme Mustang_Vim_Colorscheme_by_hcalves
"set guifont=Monaco\ 9

colorscheme molokai
set guifont=Inconsolata\ 12
set linespace=1
