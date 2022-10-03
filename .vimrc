" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/bundle/')
" Install by running .vim/install-plug.sh
" https://vimawesome.com/

" Git diff in the gutter (sign column)
Plug 'airblade/vim-gitgutter'

" A collection of language packs for Vim.
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" A command-line fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Prettier
Plug 'prettier/vim-prettier'

" Initialize plugin system
call plug#end()

" The default vimrc file.
" https://github.com/vim/vim/blob/master/runtime/defaults.vim
runtime! defaults.vim

" Source viminit files
runtime! config/**/*.vim

if filereadable(".vimrc.local")
  so .vimrc.local
endif

set hlsearch
set diffopt+=iwhite

set expandtab tabstop=2 shiftwidth=2
set autoindent
set smartindent

" Automatically set current directory to file's location
set autochdir

" Don't use swap files at all
set noswapfile

" Permit changing buffers without saving
set hidden

" Autowrap text
"set formatoptions+=ta textwidth=80

" Customize statusline
set laststatus=2
"set statusline=%<#%n\ %F\ %h%m%r%y%=0x%B\ %c,%l/%L\ %P

" Display tabs and trailing spaces
"set list listchars=tab:  ,trail:⋅,nbsp:⋅

" neovim
set mouse=a
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

noremap <c-p> :GFiles<CR>
