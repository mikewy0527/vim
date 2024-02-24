"======================================================================
"
" quickui_mode.vim - 
"
" Created by skywind on 2024/02/24
" Last Modified: 2024/02/24 19:13:33
"
"======================================================================

"----------------------------------------------------------------------
" internal
"----------------------------------------------------------------------
let s:has_popup = exists('*popup_create') && v:version >= 800
let s:has_floating = has('nvim-0.4')
let s:has_vim_820 = (has('nvim') == 0 && has('patch-8.2.1'))
let s:has_version = s:has_vim_820 || has('nvim-0.5.0')
let s:enabled = s:has_version && (s:has_popup || s:has_floating)


"----------------------------------------------------------------------
" setup
"----------------------------------------------------------------------
let g:asclib = get(g:, 'asclib', {})
let g:asclib.ui = get(g:asclib, 'ui', {})


"----------------------------------------------------------------------
" input
"----------------------------------------------------------------------
function! s:proc_input(prompt, text, name)
	if a:name == ''
		return quickui#input#open(a:prompt, a:text)
	else
		return quickui#input#open(a:prompt, a:text, a:name)
	endif
endfunc


"----------------------------------------------------------------------
" initialize
"----------------------------------------------------------------------
function! module#mode#quickui_mode#init() abort
	if get(g:, 'quickui_disable', 0)
		return -1
	endif
	let g:asclib.ui.input = function('s:proc_input')
	return 0
endfunc


"----------------------------------------------------------------------
" quit
"----------------------------------------------------------------------
function! module#mode#quickui_mode#quit() abort
endfunc




