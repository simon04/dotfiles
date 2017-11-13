" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/bundle/')
" a frontend for ack/ag (grep alternatives)
Plug 'mileszs/ack.vim'
" Molokai color scheme for Vim
Plug 'tomasr/molokai'
" full path fuzzy file, buffer, mru, tag finder, :CtrlP, <c-p>
Plug 'ctrlpvim/ctrlp.vim'
" Git diff in the gutter (sign column)
Plug 'airblade/vim-gitgutter'
" a Git wrapper
Plug 'tpope/vim-fugitive'
" light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'
" Initialize plugin system
call plug#end()

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

set wrap showbreak=::::
set linebreak textwidth=0
"set formatoptions=tcqaw

" Autowrap text
"set formatoptions+=ta textwidth=80

" Customize statusline
set laststatus=2
set statusline=%<#%n\ %F\ %h%m%r%y%=0x%B\ %c,%l/%L\ %P

" Display tabs and trailing spaces
"set list listchars=tab:  ,trail:⋅,nbsp:⋅

" vertical/horizontal scroll off settings
"set scrolloff=4
"set sidescrolloff=8
"set sidescroll=1

let isfname="@,48-57,/,.,-,_,+,,,#,$,%,~"

" Do not increment 07 to 10 (octal, or hexadecimal respectively)
set nrformats=
