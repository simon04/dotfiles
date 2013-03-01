let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 2
if exists("DetectIndent")
  autocmd BufRead,BufWrite * DetectIndent
endif
