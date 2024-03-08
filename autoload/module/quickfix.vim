"======================================================================
"
" quickfix.vim - 
"
" Created by skywind on 2024/03/08
" Last Modified: 2024/03/08 17:33:22
"
"======================================================================


"----------------------------------------------------------------------
" 
"----------------------------------------------------------------------
function! module#quickfix#filter() abort
	let l:qflist = getqflist()
	let l:qf = []
	for l:item in l:qflist
		if l:item.valid
			call add(l:qf, l:item)
		endif
	endfor
	call setqflist(l:qf)
endfunc


