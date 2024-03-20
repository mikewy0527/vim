"======================================================================
"
" go.vim - 
"
" Created by skywind on 2024/03/20
" Last Modified: 2024/03/20 23:37:53
"
"======================================================================


"----------------------------------------------------------------------
" internal 
"----------------------------------------------------------------------
let s:has_goimports = executable('goimports')? 1 : 0
let s:inited = 0


"----------------------------------------------------------------------
" init 
"----------------------------------------------------------------------
function! module#go#init()
	if &bt == '' && &ft == 'go'
		if s:inited == 0
			augroup ModuleGoEvents
				au!
				au BufWritePre *.go :call module#go#format()
			augroup END
			let s:inited = 1
		endif
	endif
endfunc


"----------------------------------------------------------------------
" format  
"----------------------------------------------------------------------
function! module#go#format()
	if s:has_goimports
		if get(g:, 'asclib_go_post_format', 0)
			call asclib#text#format('goimports')
		endif
	endif
endfunc



