" Vim syntax file
" Language: KISTERS ZRXP format
" Maintainer: Simon Legner <Simon.Legner@gmail.com>

if exists("b:current_syntax")
  finish
endif

" ZRXP comment
syn match zrxpComment "^##.*"

" ZRXP header
syn match zrxpString "^#[^#].*" contains=zrxpOperator,zrxpDefine,zrxpDelimiter
syn match zrxpOperator "CKONV"
syn match zrxpOperator "CNAME"
syn match zrxpOperator "CTAGKEY"
syn match zrxpOperator "CUNIT"
syn match zrxpOperator "LAYOUT"
syn match zrxpOperator "REXCHANGE"
syn match zrxpOperator "RINVAL"
syn match zrxpOperator "SANR"
syn match zrxpOperator "SNAME"
syn match zrxpOperator "SWATER"
syn match zrxpOperator "TSPATH"
syn match zrxpOperator "TZ"
syn match zrxpOperator "XTRUNCATE"
syn match zrxpOperator "ZRXPCREATOR"
syn match zrxpOperator "ZRXPVERSION"
syn match zrxpDefine "\(REXCHANGE\)\@<=[^|*]*"
syn match zrxpDelimiter "\V;*;"
syn match zrxpDelimiter "\V|*|"

" ZRXP data
syn region zrxpString start=+"+ end=+"+ oneline
syn match zrxpType "\v^[0-9]{8}"

hi def link zrxpComment Comment
hi def link zrxpDefine Define
hi def link zrxpDelimiter Delimiter
hi def link zrxpKeyword Keyword
hi def link zrxpOperator Operator
hi def link zrxpString String
hi def link zrxpType Type

let b:current_syntax = "zrxp"
