" https://github.com/gmarik/vundle
set rtp+=~/.vim/vundle/
call vundle#rc()
Bundle 'altercation/vim-colors-solarized'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'ciaranm/securemodelines'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'tomasr/molokai'
Bundle 'aclindsa/detectindent'
Bundle 'kien/ctrlp.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'git://repo.or.cz/vcscommand'
Bundle 'bling/vim-airline'

" Source viminit files
runtime! config/**/*.vim

if filereadable(".vimrc.local")
  so .vimrc.local
endif

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
"set list listchars=tab:  ,trail:⋅,nbsp:⋅

" vertical/horizontal scroll off settings
set scrolloff=4
set sidescrolloff=8
set sidescroll=1

" http://www.jukie.net/bart/blog/vim-modelines-insecure
" use secure_modelines instead
set modelines=0

" Auto closing an HTML tag
:iabbrev </ </<C-X><C-O>
