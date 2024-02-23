"======================================================================
"
" mode.vim - 
"
" Created by skywind on 2024/02/23
" Last Modified: 2024/02/23 22:16:45
"
"======================================================================


"----------------------------------------------------------------------
" internal
"----------------------------------------------------------------------
let s:scriptname = expand('<sfile>:p')
let s:scripthome = fnamemodify(s:scriptname, ':h:h')
let s:windows = has('win32') || has('win64') || has('win16') || has('win95')
let s:current = ''


"----------------------------------------------------------------------
" find files in: autoload/module/mode
"----------------------------------------------------------------------
function! s:find_script() abort
	let found = {}
	for fn in asclib#path#lookup('autoload/module/mode', '*.vim')
		let name = asclib#path#basename(fn)
		let main = asclib#path#splitext(name)[0]
		let found[main] = fn
	endfor
	return found
endfunc


"----------------------------------------------------------------------
" switch mode
"----------------------------------------------------------------------
function! module#mode#switch(name) abort
	if s:current != ''
		let pname = printf('module#mode#%s#quit', a:name)
		if exists('*' . pname)
			try
				call call(pname, [])
			catch
				call asclib#common#errmsg('ModeSwitch: ' . v:exception)
			endtry
		endif
		let s:current = ''
	endif
	let scripts = s:find_script()
	if !has_key(scripts, a:name)
		call asclib#common#errmsg('ModeSwitch: mode not found: ' . a:name)
		return -1
	endif
	exec 'source ' . fnameescape(scripts[a:name])
	let s:current = a:name
	let pname = printf('module#mode#%s#init', s:current)
	call call(pname, [])
	return 0
endfunc


"----------------------------------------------------------------------
" get current mode name
"----------------------------------------------------------------------
function! module#mode#current() abort
	return s:current
endfunc


"----------------------------------------------------------------------
" list available modes
"----------------------------------------------------------------------
function! module#mode#list() abort
	let scripts = s:find_script()
	return keys(scripts)
endfunc




