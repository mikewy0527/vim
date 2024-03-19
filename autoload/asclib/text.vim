"======================================================================
"
" text.vim - 
"
" Created by skywind on 2024/03/19
" Last Modified: 2024/03/19 18:01
"
"======================================================================


"----------------------------------------------------------------------
" https://github.com/lilydjwg/dotvim 
"----------------------------------------------------------------------
function! asclib#text#match_at_cursor(pattern) abort
	return asclib#string#matchat(getline('.'), a:pattern, col('.') - 1)
endfunc



