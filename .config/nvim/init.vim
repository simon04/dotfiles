" Plugins managed by vim.pack (Neovim 0.12+), see :help vim.pack
" Update with :lua vim.pack.update()
lua << EOF
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then
        vim.cmd.packadd('nvim-treesitter')
      end
      vim.cmd('TSUpdate')
    end
  end,
})

vim.pack.add({
  -- Git integration for buffers
  'https://github.com/lewis6991/gitsigns.nvim',
  -- A collection of language packs for Vim.
  'https://github.com/nvim-treesitter/nvim-treesitter',
})

require('gitsigns').setup()
EOF

" Source viminit files
runtime! config/**/*.vim

if filereadable(".vimrc.local")
  so .vimrc.local
endif

set expandtab tabstop=2 shiftwidth=2
set smartindent

" Automatically set current directory to file's location
set autochdir

" Don't use swap files at all
set noswapfile

" Autowrap text
"set formatoptions+=ta textwidth=80

" Customize statusline
"set statusline=%<#%n\ %F\ %h%m%r%y%=0x%B\ %c,%l/%L\ %P

" Display tabs and trailing spaces
"set list listchars=tab:  ,trail:⋅,nbsp:⋅

" neovim
set mouse=a
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p
