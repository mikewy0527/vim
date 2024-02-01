"======================================================================
"
" basic.vim - 
"
" Created by skywind on 2024/01/31
" Last Modified: 2024/01/31 16:11:21
"
"======================================================================


"----------------------------------------------------------------------
" native names
"----------------------------------------------------------------------
let s:native_names = [
	\ 'Added', 'Boolean', 'Changed', 'Character', 'ColorColumn', 'Comment',
	\ 'Conceal', 'Conditional', 'Constant', 'CurSearch', 'Cursor',
	\ 'CursorColumn', 'CursorIM', 'CursorLine', 'CursorLineFold',
	\ 'CursorLineNr', 'CursorLineSign', 'Debug', 'Define', 'Delimiter',
	\ 'DiffAdd', 'DiffChange', 'DiffDelete', 'DiffText', 'Directory',
	\ 'EndOfBuffer', 'Error', 'ErrorMsg', 'Exception', 'Float',
	\ 'FoldColumn', 'Folded', 'Function', 'Identifier', 'Ignore',
	\ 'IncSearch', 'Include', 'Keyword', 'Label', 'LineNr', 'LineNrAbove',
	\ 'LineNrBelow', 'Macro', 'MatchParen', 'MessageWindow', 'ModeMsg',
	\ 'MoreMsg', 'NonText', 'Normal', 'Number', 'Operator', 'Pmenu',
	\ 'PmenuExtra', 'PmenuExtraSel', 'PmenuKind', 'PmenuKindSel',
	\ 'PmenuSbar', 'PmenuSel', 'PmenuThumb', 'PopupNotificatio',
	\ 'PreCondit', 'PreProc', 'Question', 'QuickFixLine', 'Removed',
	\ 'Repeat', 'Search', 'SignColumn', 'Special', 'SpecialChar',
	\ 'SpecialComment', 'SpecialKey', 'SpellBad', 'SpellCap', 'SpellLocal',
	\ 'SpellRare', 'Statement', 'StatusLine', 'StatusLineNC',
	\ 'StatusLineTerm', 'StatusLineTermNC', 'StorageClass', 'String',
	\ 'Structure', 'TabLine', 'TabLineFill', 'TabLineSel', 'Tag',
	\ 'Terminal', 'Title', 'Todo', 'ToolbarButton', 'ToolbarLine', 'Type',
	\ 'Typedef', 'Underlined', 'VertSplit', 'Visual', 'VisualNOS',
	\ 'WarningMsg', 'WildMenu', 'lCursor',
	\ ]


"----------------------------------------------------------------------
" extend_link
"----------------------------------------------------------------------
function! colorexp#basic#extend_link(list) abort
	let list = deepcopy(a:list)
	let dict = {}
	for name in list
		let dict[name] = 1
	endfor
	let index = 0
	while index < len(list)
		let name = list[index]
		if hlexists(name)
			let hid = hlID(name)
			let link = synIDtrans(hid)
			" echo printf("name=%s hid=%d link=%d", name, hid, link)
			if hid != link
				let linkname = synIDattr(link, 'name')
				if !has_key(dict, linkname)
					let dict[linkname] = 1
					let list += [linkname]
				endif
			endif
		endif
		let index += 1
	endwhile
	let output = []
	let dict = {}
	for name in list
		if !has_key(dict, name)
			let output += [name]
			let dict[name] = 1
		endif
	endfor
	return output
endfunc


"----------------------------------------------------------------------
" collect required names
"----------------------------------------------------------------------
function! colorexp#basic#collect() abort
	let output = []
	if get(g:, 'color_export_all', 0)
		let hid = 1
		while 1
			let name = synIDattr(hid, 'name')
			if !hlexists(name)
				break
			endif
			let output += [name]
			let hid += 1
		endwhile
	else
		let extra = []
		if exists('g:color_export_extra')
			if type(g:color_export_extra) == type([])
				let extra = g:color_export_extra
			elseif type(g:color_export_extra) == type('')
				let extra = split(g:color_export_extra, ',')
			endif
		endif
		let output = colorexp#basic#extend_link(s:native_names + extra)
	endif
	return output
endfunc


"----------------------------------------------------------------------
" 
"----------------------------------------------------------------------
function! colorexp#basic#test1() abort
	let list = ['CursorLine', 'CursorLineSign', 'CursorLineFold', 'QuickFixLine']
	let newlist = colorexp#basic#extend_link(list)
	for name in newlist
		echo name
	endfor
endfunc

function! colorexp#basic#test2()
	let list1 = s:native_names
	let list2 = colorexp#basic#extend_link(list1)
	echo printf("%d %d", len(list1), len(list2))
endfunc

" call colorexp#basic#test1()


