command! BuffDiff :w !diff -u % -
command! CD cd `dirname %`
command! Reverse :g/^/m0

function! StripWhitespace ()
  exec ':%s/ \+$//gc'
endfunction
map ,w :call StripWhitespace ()<CR>

" Using xmllint from package libxml2
command! FormatXML :% !xmllint --format --recover -

" Using jq to format JSON
command! FormatJSON :% !jq
