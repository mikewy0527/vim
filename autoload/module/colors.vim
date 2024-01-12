
"----------------------------------------------------------------------
" 
"----------------------------------------------------------------------
function! module#colors#reset_comment()
	hi! clear Comment
	hi! Comment term=bold ctermfg=243 guifg=#65737e
endfunc


"----------------------------------------------------------------------
" 
"----------------------------------------------------------------------
function! module#colors#gui2term()
	let hid = 1
	let output = []
	while 1
		let hln = synIDattr(hid, 'name')
		if !hlexists(hln) 
			break
		endif
		let link = synIDtrans(hid)
		if hid == link

		else
			let linkname = synIDattr(link, 'name')
			echo printf("hi link %s %s", hln, linkname)
		endif
		" let output += [hln]
		" echo hln
		let hid += 1
	endwhile
	echo hid
endfunc

call module#colors#gui2term()


