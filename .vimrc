" https://github.com/gmarik/vundle
set rtp+=~/.vim/vundle/
call vundle#rc()
" a syntax checking plugin using external syntax checkers
Bundle 'scrooloose/syntastic'
" a frontend for ack/ag (grep alternatives)
Bundle 'mileszs/ack.vim'
" quoting/parenthesizing made simple, ys[motion][surrounding], ds[surrounding], cs[old][new]
Bundle 'tpope/vim-surround'
" lightweight Toolbox for LaTeX
Bundle 'LaTeX-Box-Team/LaTeX-Box'
" Molokai color scheme for Vim
Bundle 'tomasr/molokai'
" automatically detecting indent settings
Bundle 'ciaranm/detectindent'
" full path fuzzy file, buffer, mru, tag finder, :CtrlP, <c-p>
Bundle 'kien/ctrlp.vim'
" git diff in the gutter (sign column)
Bundle 'airblade/vim-gitgutter'
" svn/git/hg integration for committing, diff, ...
Bundle 'git://repo.or.cz/vcscommand'
" fancy and lightweight status line
Bundle 'bling/vim-airline'
" list of buffers in the status line
Bundle 'bling/vim-bufferline'
" allows to `vim file:line`
Bundle 'bogado/file-line'

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

if !exists("DetectIndent")
  set expandtab tabstop=2 shiftwidth=2
endif

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

" Auto closing an HTML tag
:iabbrev </ </<C-X><C-O>

let isfname="@,48-57,/,.,-,_,+,,,#,$,%,~"

" Do not increment 07 to 10 (octal, or hexadecimal respectively)
set nrformats=
