"----------------------------------------------------------------------
" detection
"----------------------------------------------------------------------
let s:windows = has('win32') || has('win16') || has('win95') || has('win64')
let g:asclib = get(g:, 'asclib', {})
let g:asclib#common#windows = s:windows
let g:asclib#common#unix = (s:windows == 0)? 1 : 0
let g:asclib#common#path = fnamemodify(expand('<sfile>:p'), ':h:h:h')


"----------------------------------------------------------------------
" error message
"----------------------------------------------------------------------
function! asclib#common#errmsg(text)
	redraw
	echohl ErrorMsg
	echom a:text
	echohl None
endfunc


"----------------------------------------------------------------------
" returns v:echospace
"----------------------------------------------------------------------
function! asclib#common#echospace() abort
	if exists('v:echospace')
		return v:echospace
	endif
	let statusline = (&laststatus == 2)? 1 : 0
	let statusline = statusline || (&laststatus == 1 && winnr('$') > 1)
    let reqspaces_lastline = (statusline || !&ruler) ? 12 : 29
    return &columns - reqspaces_lastline
endfunc


"----------------------------------------------------------------------
" echo message (size safe)
"----------------------------------------------------------------------
function! asclib#common#echo(highlight, text, ...) abort
	let text = (a:0 == 0)? a:text : a:text . join(a:000, ' ')
	let pos = stridx(text, "\n")
	if pos >= 0
		let text = strpart(text, 0, pos)
	endif
	let text = strpart(text, 0, asclib#common#echospace() - 1)
	redraw
	if a:highlight != ''
		exec 'echohl ' . a:highlight
	endif
	echo text
	echohl None
endfunc


"----------------------------------------------------------------------
" notify
"----------------------------------------------------------------------
function! asclib#common#notify(text, type) abort
	let text = (a:type == '')? a:text : printf("[%s] %s", a:type, a:text)
	call asclib#common#echo('Special', text)
endfunc


"----------------------------------------------------------------------
" class.word
"----------------------------------------------------------------------
function! asclib#common#class_word()
	let text = getline('.')
	let pre = text[:col('.') - 1]
	let suf = text[col('.'):]
	let word = matchstr(pre, "[A-Za-z0-9_.]*$") 
	let word = word . matchstr(suf, "^[A-Za-z0-9_]*")
	let cword = expand('<cword>')
	return (strlen(word) > strlen(cword))? word : cword
endfunc


"----------------------------------------------------------------------
" get region text
"----------------------------------------------------------------------
function! s:GetRegionText(pos1, pos2, mode)
	if exists('*getregion') && has('patch-9.1.128') && 0
		let mode = (a:mode == "b")? "\<c-v>" : a:mode
		return join(getregion(a:pos1, a:pos2, mode))
	endif
	let [line_start, column_start] = [line(a:pos1), charcol(a:pos1)]
	let [line_end, column_end]     = [line(a:pos2), charcol(a:pos2)]
	let delta = line_end - line_start
	if delta < 0 || (delta == 0 && column_start > column_end)
		let [line_start, line_end] = [line_end, line_start]
		let [column_start, column_end] = [column_end, column_start]
	endif
	let lines = getline(line_start, line_end)
	let inclusive = (&selection == 'inclusive')? 1 : 2
	if a:mode ==# 'v'
		" Must trim the end before the start, the beginning will shift left.
		let lines[-1] = strcharpart(lines[-1], 0, column_end - inclusive + 1)
		let lines[0] = strcharpart(lines[0], column_start - 1)
	elseif  a:mode ==# 'V'
	" Line mode no need to trim start or end
	elseif  a:mode == "\<c-v>" || a:mode == 'b'
		" Block mode, trim every line
		let w = column_end - inclusive + 2 - column_start
		let i = 0
		for line in lines
			let lines[i] = strcharpart(line, column_start - 1, w)
			let i = i + 1
		endfor
	else
		return ''
	endif
	return join(lines, "\n")
endfunc


"----------------------------------------------------------------------
" get selected text
"----------------------------------------------------------------------
function! asclib#common#get_selected_text(...)
	let mode = get(a:, 1, mode(1))
	return s:GetRegionText("'<", "'>", mode)
endfunc


"----------------------------------------------------------------------
" keywords complete
"----------------------------------------------------------------------
function! asclib#common#complete(ArgLead, CmdLine, CursorPos, Keywords)
	let candidate = []
	for word in a:Keywords
		if asclib#string#startswith(word, a:ArgLead)
			let candidate += [word]
		endif
	endfor
	return candidate
endfunc



"----------------------------------------------------------------------
" print lines
"----------------------------------------------------------------------
function! asclib#common#print_content(content) abort
	for text in a:content
		echo text
	endfor
endfunc


"----------------------------------------------------------------------
" timing
"----------------------------------------------------------------------
function! asclib#common#timeit(func, ...)
	let start = reltime()
	try
		call call(a:func, a:000)
	catch
		echohl ErrorMsg
		echo "Error: " . v:exception
		echohl None
	endtry
	let end = reltime()
	let time = reltimestr(reltime(start, end))
	return time
endfunc





