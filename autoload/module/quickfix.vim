"======================================================================
"
" quickfix.vim - 
"
" Created by skywind on 2024/03/08
" Last Modified: 2024/03/08 17:33:22
"
"======================================================================


"----------------------------------------------------------------------
" filter unused quickfix items
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


"----------------------------------------------------------------------
" convert encoding for quickfix items
"----------------------------------------------------------------------
function! module#quickfix#iconv(encoding) abort
	if &encoding == a:encoding
		return -1
	elseif !exists('*iconv')
		return -1
	endif
	let l:qflist = getqflist()
	for i in l:qflist
		let i.text = iconv(i.text, a:encoding, &encoding)
	endfor
	return 0
endfunc


"----------------------------------------------------------------------
" ensure encoding for quickfix items
"----------------------------------------------------------------------
function! module#quickfix#ensure_encoding() abort
	let encoding = get(g:, 'asyncrun_encs', '')
	if encoding != ''
		call module#quickfix#iconv(encoding)
	endif
endfunc


"----------------------------------------------------------------------
" returns window number
"----------------------------------------------------------------------
function! module#quickfix#search_window()
	return asclib#window#search("quickfix", 'qf', 0)
endfunc


"----------------------------------------------------------------------
" move cursor in quickfix window
"----------------------------------------------------------------------
function! module#quickfix#scroll(mode) abort
	let num = module#quickfix#search_window()
	if num > 0
		let cmd = ''
		if a:mode == 0
			let cmd = "normal! \<c-y>"
		elseif a:mode == 1
			let cmd = "normal! \<c-e>"
		elseif a:mode == 2
			let cmd = "normal! ".winheight(num)."\<c-y>"
		elseif a:mode == 3
			let cmd = "normal! ".winheight(num)."\<c-e>"
		elseif a:mode == 4
			let cmd = 'normal! gg'
		elseif a:mode == 5
			let cmd = 'normal! G'
		elseif a:mode == 6
			let cmd = "normal! \<c-u>"
		elseif a:mode == 7
			let cmd = "normal! \<c-d>"
		elseif a:mode == 8
			let cmd = "normal! k"
		elseif a:mode == 9
			let cmd = "normal! j"
		endif
		noautocmd call asclib#window#execute(num, cmd)
	endif
endfunc



