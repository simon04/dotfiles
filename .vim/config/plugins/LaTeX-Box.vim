au BufNewFile,BufRead *.tex imap <buffer> [[ \begin{
au BufNewFile,BufRead *.tex imap <buffer> ]] <Plug>LatexCloseCurEnv
au BufNewFile,BufRead *.tex nmap <buffer> <F5> <Plug>LatexChangeEnv
au BufNewFile,BufRead *.tex vmap <buffer> <F7> <Plug>LatexWrapSelection
au BufNewFile,BufRead *.tex vmap <buffer> <S-F7> <Plug>LatexEnvWrapSelection
au BufNewFile,BufRead *.tex imap <buffer> (( \eqref{
