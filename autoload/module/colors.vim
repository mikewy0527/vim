
"----------------------------------------------------------------------
" 
"----------------------------------------------------------------------
function! module#colors#reset_comment()
	hi! clear Comment
	hi! Comment term=bold ctermfg=243 guifg=#65737e
endfunc


"----------------------------------------------------------------------
" convert to term
"----------------------------------------------------------------------
function! module#colors#dump_highlight(gui2term)
	let hid = 1
	let output = []
	while 1
		let hln = synIDattr(hid, 'name')
		if !hlexists(hln) 
			break
		endif
		let link = synIDtrans(hid)
		if hid == link
			let part = []
			let guifg = synIDattr(hid, 'fg', 'gui')
			let guibg = synIDattr(hid, 'bg', 'gui')
			let ctermfg = synIDattr(hid, 'fg', 'cterm')
			let ctermbg = synIDattr(hid, 'bg', 'cterm')
			if a:gui2term
				let ctermfg = ''
				let ctermbg = ''
			endif
			if ctermfg == ''
				if guifg != ''
					let ctermfg = quickui#palette#name2index(guifg)
				else
					let ctermfg = 'NONE'
				endif
			endif
			if ctermbg == ''
				if guibg != ''
					let ctermbg = quickui#palette#name2index(guibg)
				else
					let ctermbg = 'NONE'
				endif
			endif
			let guifg = (guifg == '')? 'NONE' : guifg
			let guibg = (guibg == '')? 'NONE' : guibg
			let fmt = 'guifg=%s guibg=%s ctermfg=%s ctermbg=%s'
			let part += [printf(fmt, guifg, guibg, ctermfg, ctermbg)]
			echo part
		else
			let linkname = synIDattr(link, 'name')
			" echo printf("hi link %s %s", hln, linkname)
		endif
		" let output += [hln]
		" echo hln
		let hid += 1
	endwhile
	echo hid
endfunc

call module#colors#dump_highlight(1)


