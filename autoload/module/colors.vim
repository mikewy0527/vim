
"----------------------------------------------------------------------
" reset comment
"----------------------------------------------------------------------
function! module#colors#reset_comment()
	hi! clear Comment
	hi! Comment term=bold ctermfg=243 guifg=#65737e
endfunc


"----------------------------------------------------------------------
" dump style
"----------------------------------------------------------------------
function! module#colors#dump_style(hid, mode)
	let hid = (type(a:hid) == 0)? (a:hid) : hlID(a:hid)
	let t = ['underline', 'undercurl', 'reverse', 'inverse']
	let t += ['italic', 'bold', 'standout']
	call filter(t, 'synIDattr(hid, v:val, a:mode)')
	let r = empty(t)? 'NONE' : join(t, ',')
	return r
endfunc


"----------------------------------------------------------------------
" dump highlight group
"----------------------------------------------------------------------
function! module#colors#dump_highlight(hid, gui2term) abort
	let hid = (type(a:hid) == 0)? (a:hid) : hlID(a:hid)
	let name = synIDattr(hid, 'name')
	if !hlexists(name) 
		return ''
	endif
	let link = synIDtrans(hid)
	if hid != link
		let linkname = synIDattr(link, 'name')
		return printf("hi link %s %s", name, linkname)
	endif
	let part = []
	let gui = module#colors#dump_style(hid, 'gui')
	let term = module#colors#dump_style(hid, 'term')
	let cterm = module#colors#dump_style(hid, 'cterm')
	if cterm == '' || a:gui2term
		let cterm = gui
	endif
	if gui != ''
		let part += ['gui=' .. gui]
	endif
	if term != ''
		let part += ['term=' .. term]
	endif
	if cterm != ''
		let part += ['cterm=' .. cterm]
	endif
	let guifg = synIDattr(hid, 'fg', 'gui')
	let guibg = synIDattr(hid, 'bg', 'gui')
	let guisp = synIDattr(hid, 'sp', 'gui')
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
	if guisp != ''
		let part += ['guisp=' .. guisp]
	endif
	if gui == 'NONE' && term == 'NONE' && cterm == 'NONE'
		if guifg == 'NONE' && guibg == 'NONE' && ctermfg == 'NONE'
			if ctermbg == 'NONE' && guisp == ''
				return printf('hi clear %s', name)
			endif
		endif
	endif
	return printf('hi %s %s', name, join(part, ' '))
endfunc


"----------------------------------------------------------------------
" convert to term
"----------------------------------------------------------------------
function! module#colors#list_highlight(gui2term)
	let hid = 1
	let output = []
	while 1
		let hln = synIDattr(hid, 'name')
		if !hlexists(hln) 
			break
		endif
		let t = module#colors#dump_highlight(hid, a:gui2term)
		let output += [t]
		let hid += 1
	endwhile
	return output
endfunc



