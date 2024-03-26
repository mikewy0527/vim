"======================================================================
"
" go.vim - 
"
" Created by skywind on 2024/03/26
" Last Modified: 2024/03/26 07:51:52
"
"======================================================================

if get(g:, 'colors_name', '') == 'borland256'
	syntax match goMark2 '('
	syntax match goMark2 ')'
	syntax match goMark2 '{'
	syntax match goMark2 '}'
	" syntax match goMark2 '['
	" syntax match goMark2 ']'
	hi! def link goMark2 Statement
	" unsilent echom 'fuck go'
endif


