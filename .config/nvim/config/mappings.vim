map 0 ^
nore ; :
nore , ;

" Move by display line, but by real line with a count (e.g. 5j)
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Force to learn hjkl
" http://stackoverflow.com/questions/5367760/vim-disabling-the-cursor-arrow-keys-but-only-for-navigation
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Buffer navigation
map <right> :bn<cr>
map <left> :bp<cr>

" Split window navigation
map <down> <c-w>w
map <up> <c-w>W

" Will allow you to use :W!! to write to a file using sudo if you forgot to sudo vim file (it will prompt for sudo password when writing)
cnoremap <expr> W!! getcmdtype() == ':' ? 'SudoWrite' : 'W!!'

" Toggle spell checking on and off with `<leader>s` (English) and `<leader>d` (German)
nmap <silent> <leader>s :set spell! spelllang=en<CR>
nmap <silent> <leader>d :set spell! spelllang=de<CR>

" Create File if not exist
nnoremap gf :e <cfile><CR>
