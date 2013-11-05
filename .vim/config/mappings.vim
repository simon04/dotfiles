map 0 ^
nore ; :
nore , ;
"inoremap jj <Esc>

" make Y consistent with C and D
nnoremap Y y$

nnoremap j gj
nnoremap k gk

" Force to learn hjkl
" http://stackoverflow.com/questions/5367760/vim-disabling-the-cursor-arrow-keys-but-only-for-navigation
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Buffer navigation
":nmap <C-left> :bprev<CR>
":nmap <C-right> :bnext<CR>
map <right> :bn<cr>
map <left> :bp<cr>

" Split window navigation
"nmap <c-down> <c-w>w
"nmap <c-up> <c-w>W
map <down> <c-w>w
map <up> <c-w>W

" Will allow you to use :w!! to write to a file using sudo if you forgot to sudo vim file (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" "Very magic" regexes in searches
"nnoremap / /\v
"nnoremap ? ?\v

" Create File if not exist
nnoremap gc :e <cfile><cr>

