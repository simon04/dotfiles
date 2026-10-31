command! BuffDiff :w !diff -u % -

" Using xmllint from package libxml2
command! FormatXML :% !xmllint --format --recover -

" Using jq to format JSON
command! FormatJSON :% !jq
