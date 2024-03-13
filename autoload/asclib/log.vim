"======================================================================
"
" log.vim - 
"
" Created by skywind on 2024/03/13
" Last Modified: 2024/03/13 17:22:27
"
"======================================================================


"----------------------------------------------------------------------
" config
"----------------------------------------------------------------------
let s:channel_enabled = {'debug':1, 'info':1, 'warn':1, 'error':1, 'fatal':1}
let s:log_path = '~/.vim/logs'
let s:log_file = 1
let s:log_echo = 0


"----------------------------------------------------------------------
" enable channel
"----------------------------------------------------------------------
function! asclib#log#enable(channel, enabled) abort
	let s:channel_enabled[a:channel] = a:enabled
endfunc


"----------------------------------------------------------------------
" log output
"----------------------------------------------------------------------
function! s:writelog(text, ...) abort
	let text = (a:0 == 0)? a:text : a:text . ' '. join(a:000, ' ')
	let time = strftime('%Y-%m-%d %H:%M:%S')
	let name = 'm'. strpart(time, 0, 10) . '.log'
	let name = substitute(name, '-', '', 'g')
	let path = expand(get(g:asclib, 'log_path', '~/.vim/logs'))
	let text = '['.time.'] ' . text
	let name = path .'/'. name
	if get(g:asclib, 'log_file', 1) != 0
		if exists('*writefile')
			if !isdirectory(path)
				silent! call mkdir(path, 'p')
			endif
			silent! call writefile([text . "\n"], name, 'a')
		endif
	endif
	if get(g:asclib, 'log_echo', 0) != 0
		echom text
	endif
	return 1
endfunc


