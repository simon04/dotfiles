let g:tex_flavor = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_UseMakefile = 0
let g:Imap_UsePlaceHolders = 0
let g:Tex_HotKeyMappings = 'align*,itemize,figure,example'
let g:Tex_ViewRule_pdf = 'zathura'
"let g:Tex_FoldedEnvironments = "figure,table"
let g:Tex_Folding=0
map <f2> <esc>:w<cr><leader>ll
imap <f2> <esc>:w<cr><leader>ll

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
