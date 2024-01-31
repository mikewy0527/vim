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
]


"----------------------------------------------------------------------
" extend_link
"----------------------------------------------------------------------
function! colorexp#basic#extend_link(list) abort
	let list = deepcopy(a:list)
	let dict = {}
	for name in list
		let dict[name] = 1
	endfor
endfunc



