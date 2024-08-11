"======================================================================
"
" c3.vim - c3 language module
"
" Created by mikewy0527
"
"======================================================================

"----------------------------------------------------------------------
" guard: take care vim-plug call setfiletype multiple times
"----------------------------------------------------------------------
if exists('b:ftplugin_init_c3')
	if get(b:, 'did_ftplugin', 0) == 2
		finish
	endif
endif

let b:ftplugin_init_c3 = 1

" prevent vim-plug set ft=? twice
if exists('b:did_ftplugin')
	let b:did_ftplugin = 2
endif

setlocal commentstring=//\ %s
let b:commentary_format = "// %s"
