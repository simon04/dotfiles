" https://github.com/tpope/vim-pathogen
source ~/.vim/bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

" Source viminit files
runtime! config/**/*.vim

set nocompatible
set hlsearch
set incsearch
set mouse=a
set diffopt+=iwhite

"set background=dark
"colorscheme solarized

set expandtab tabstop=2 shiftwidth=2

syntax on
filetype plugin indent on
set autoindent
set smartindent

" Automatically set current directory to file's location
set autochdir

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

" Customize statusline
set laststatus=2
set statusline=%<#%n\ %F\ %h%m%r%y%=0x%B\ %c,%l/%L\ %P

" Display tabs and trailing spaces
"set list
"set listchars=tab:  ,trail:⋅,nbsp:⋅

" vertical/horizontal scroll off settings
set scrolloff=4
set sidescrolloff=8
set sidescroll=1

" http://www.jukie.net/bart/blog/vim-modelines-insecure
set modelines=0
"let g:secure_modelines_verbose=1

" Load template associated with file extension on file creation if template is available
" http://vim.runpaint.org/typing/using-templates
autocmd! BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e | silent! 0r ~/.vim/skel/%:t

" Auto closing an HTML tag
:iabbrev </ </<C-X><C-O>




