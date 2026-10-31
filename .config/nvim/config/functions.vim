command! BuffDiff :w !diff -u % -

" Write the current file using sudo (sudo cannot prompt from within nvim)
" -k ignores cached credentials, so the password line is always consumed
function! SudoWrite()
  let password = inputsecret('[sudo] password for ' . $USER . ': ')
  let content = join(getline(1, '$'), "\n") . (&eol ? "\n" : '')
  call system(['sudo', '-k', '-S', '-p', '', 'tee', expand('%:p')], password . "\n" . content)
  if v:shell_error
    echoerr 'SudoWrite failed'
  else
    setlocal nomodified
    echo 'Written with sudo: ' . expand('%:p')
  endif
endfunction
command! -bar SudoWrite call SudoWrite()

" Using xmllint from package libxml2
command! FormatXML :% !xmllint --format --recover -

" Using jq to format JSON
command! FormatJSON :% !jq
