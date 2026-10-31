" Vim syntax file
" Language: KISTERS ZRXP format
" Maintainer: Simon Legner <Simon.Legner@gmail.com>
" Reference: https://prozessing.tbbm.at/zrxp/zrxp3.0_en.pdf

if exists("b:current_syntax")
  finish
endif

" ZRXP comment
syn match zrxpComment "^\s*##.*"

" ZRXP header: #<Keyword><value>|*|<Keyword><value>|*|...
syn match zrxpHeader "^\s*#\%(#\)\@!.*" contains=zrxpKeyword,zrxpLayoutKeyword,zrxpDelimiter
syn match zrxpDelimiter "\V|*|\|;*;" contained
" alternatives are ordered longest first, so that e.g. CTAGKEY wins over CTAG
" ZRXP 3
syn match zrxpKeyword "\v%(^\s*#|%(\|\*\||;\*;)\s*)@<=%(SOURCESYSTEM|METERNUMBER|ZRXPCREATOR|ZRXPVERSION|CCHANNELNO|CDASANAME|REXCHANGE|XTRUNCATE|CCHANNEL|RTIMELVL|SOURCEID|CTAGKEY|METCODE|RINVAL|SWATER|TASKID|TSPATH|CDASA|CNAME|CUNIT|SNAME|XVLID|ZDATE|CTAG|EDIS|SANR|CMW|CNR|TZ)" contained nextgroup=zrxpValue
" ZRXP 2, removed in ZRXP 3
syn match zrxpKeyword "\v%(^\s*#|%(\|\*\||;\*;)\s*)@<=%(METERSITE|CINSTANT|VOLATILE|ZRXPMODE|RIMPORT|CNTYPE|CTABLE|EQFLAG|REMDST|RSTATE|XCLEAN|CKONV|CTYPE|EUNIT|REXTR|RORPR|RTYPE|SSNR|PNP|RID|RNR)" contained nextgroup=zrxpValue
syn match zrxpValue "\v.{-}\ze%(\|\*\||;\*;|$)" contained
syn match zrxpLayoutKeyword "\v%(^\s*#|%(\|\*\||;\*;)\s*)@<=LAYOUT" contained nextgroup=zrxpLayout
syn match zrxpLayout "([^)]*)" contained contains=zrxpColumn
syn match zrxpColumn "\v\c<%(timestamp|value|primary_status|system_status|additional_status|interpolation_type|remark|timestampoccurr?ence|occurrencecount|member|forecast|signature|reset_number|reset_timestamp|releaselevel|dispatch_?info|status)>" contained

" ZRXP data
syn match zrxpNumber "\v%(^|\s)\zs[-+]?%(\d+\.?\d*|\.\d+)%([eE][-+]?\d+)?\ze%(\s|$)"
syn match zrxpInvalid "\v%(^|\s)\zs-777%(\.0*)?\ze%(\s|$)"
syn match zrxpTimestamp "\v^\s*\zs\d{8,14}>"
syn region zrxpString start=+"+ end=+"+ oneline contains=zrxpRemarkDelimiter
syn match zrxpRemarkDelimiter "::" contained

hi def link zrxpComment Comment
hi def link zrxpColumn Identifier
hi def link zrxpDelimiter Delimiter
hi def link zrxpInvalid Special
hi def link zrxpKeyword Keyword
hi def link zrxpLayoutKeyword Keyword
hi def link zrxpNumber Number
hi def link zrxpRemarkDelimiter Delimiter
hi def link zrxpString String
hi def link zrxpTimestamp Type
hi def link zrxpValue String

let b:current_syntax = "zrxp"
