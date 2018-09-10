command! BuffDiff :w !diff -u % -
command! CD cd `dirname %`
command! Reverse :g/^/m0

function! StripWhitespace ()
  exec ':%s/ \+$//gc'
endfunction
map ,w :call StripWhitespace ()<CR>

" from http://phdru.name/Software/dotfiles/vimrc.html
if has("iconv")
  " Helper function for :DecodeQP and :DecodeURL commands
  function! DecodeHex(arg)
    return iconv(printf("%c", str2nr(submatch(1), 16)), a:arg, &encoding)
  endfunction
  " Custom completion for encoding names
  function! EncList(ArgLead, CmdLine, CursorPos)
    return filter(split(&fileencodings, ','),
          \ "strpart(v:val, 0, strlen(a:ArgLead)) == a:ArgLead")
  endfunction
  " Command for decoding qp-encoded text
  command! -bar -nargs=? -range -complete=customlist,EncList DecodeQP
        \ <line1>,<line2>s/=\(\x\x\|\n\)/\=DecodeHex(<q-args>)/eg
  " Command for decoding url-encoded text
  command! -bar -nargs=? -range -complete=customlist,EncList DecodeURL
        \ <line1>,<line2>s/%\(\x\x\)/\=DecodeHex(<q-args>)/eg
endif

" Using xmllint from package libxml2
command! FormatXML :% !xmllint "%" --format

command! Prettier :% !prettier "%"
command! FormatHTML :% !tidy "%"
command! FormatCSS :% !css-beautify "%"

" http://vim.wikia.com/wiki/Copy_search_matches
function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
