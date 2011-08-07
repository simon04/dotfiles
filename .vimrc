set nocompatible
set hlsearch
set incsearch
set mouse=a
set diffopt+=iwhite

set expandtab tabstop=2 shiftwidth=2

syntax on
filetype plugin indent on
set autoindent
set smartindent

let g:tex_flavor = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_UseMakefile = 0
let g:Imap_UsePlaceHolders = 0
let g:Tex_HotKeyMappings = 'align*,itemize,figure,example'
let g:Tex_ViewRule_pdf = 'zathura'
map <f2> <esc>:w<cr><leader>ll
imap <f2> <esc>:w<cr><leader>ll

" Automatically set current directory to file's location
set autochdir
:command! CD cd `dirname %`

" Save swap files centrally
"silent !mkdir -m 700 -p /tmp/.vim-$USER
"set dir=/tmp/.vim-$USER

" Don't use swap files at all
set noswapfile

" Permit changing buffers without saving
set hidden

set wrap linebreak textwidth=0
"set formatoptions=tcqaw

" Autowrap text
"set formatoptions+=ta textwidth=80

" http://jlebl.wordpress.com/2011/01/13/vim-evince-and-forward-and-backward-latex-synctex-search/
"let g:Tex_ViewRule_pdf = 'evince_vim_dbus.py EVINCE'
"let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_CompileRule_pdf = 'pdflatex --synctex=1 -interaction=nonstopmode $*'

" Replacing latex code by unicode symbols (conceal)
"set cole=2
"let g:text_conceal="adgms"
"hi Conceal guibg=gray20 guifg=white
"syn match texMathSymbol '\\geqslant\>' contained conceal cchar=≥
"syn match texMathSymbol '\\leqslant\>' contained conceal cchar=≤

" [DetectIndent]
" https://github.com/ciaranm/detectindent/blob/master/doc/detectindent.txt
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 2
autocmd BufRead,BufWrite * DetectIndent

map 0 ^
nore ; :
nore , ;
"inoremap jj <Esc>

" make Y consistent with C and D
nnoremap Y y$

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

" Spell check for tex and commit messages
au BufNewFile,BufRead *.tex setl spell
au BufNewFile,BufRead COMMIT_EDITMSG setl spell

function! StripWhitespace ()
  exec ':%s/ \+$//gc'
endfunction
map ,s :call StripWhitespace ()<CR>

" Remove any trailing whitespace that is in the file
"autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

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

" Customize statusline
set laststatus=2
"set statusline=%<\ %n:%F\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
"set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set statusline=%<\ %n:%F\ %h%m%r%y%=%c,%l/%L\ %P

" Display tabs and trailing spaces
set list
"set listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set listchars=tab:  ,trail:⋅,nbsp:⋅

" vertical/horizontal scroll off settings
set scrolloff=4
set sidescrolloff=8
set sidescroll=1

" Will allow you to use :w!! to write to a file using sudo if you forgot to sudo vim file (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

" [Ragtag] enable for smarty templates
au BufNewFile,BufRead *.tpl call RagtagInit()

" http://www.jukie.net/bart/blog/vim-modelines-insecure
set modelines=0
"let g:secure_modelines_verbose=1

