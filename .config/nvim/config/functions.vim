command! BuffDiff :w !diff -u % -
command! CD cd `dirname %`
command! Reverse :g/^/m0

" Using xmllint from package libxml2
command! FormatXML :% !xmllint --format --recover -

" Using jq to format JSON
command! FormatJSON :% !jq
