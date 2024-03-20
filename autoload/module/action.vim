"======================================================================
"
" action.vim - menu / navigator actions
"
" Created by skywind on 2024/02/22
" Last Modified: 2024/02/22 22:28:20
"
"======================================================================


"----------------------------------------------------------------------
" toggle: tagbar/vista/aerial/outline
"----------------------------------------------------------------------
function! module#action#tagbar() abort
	if exists(':Vista') == 2
		exec ':Vista'
	elseif exists(':AerialToggle') == 2
		exec ':AerialToggle'
	elseif exists(':Outline') == 2
		exec ':Outline'
	elseif exists(':Tagbar') == 2
		exec ':Tagbar'
	endif
endfunc


"----------------------------------------------------------------------
" easymotion
"----------------------------------------------------------------------
function! module#action#easymotion(what) abort
	if a:what != ''
		stopinsert
		call feedkeys("\<Plug>(easymotion-" . a:what . ")", '')
	endif
endfunc


"----------------------------------------------------------------------
" ask input for grep
"----------------------------------------------------------------------
function! module#action#grep() abort
	let p = asyncrun#get_root('%')
	let t = 'Find word in (' . p . '): '
	let t = asclib#ui#input(t, expand('<cword>'), 'grep')
	let t = asclib#string#strip(t)
	redraw
	if strlen(t) > 0
		silent exec "GrepCode! ".fnameescape(t)
		call asclib#quickfix_title('- searching "'. t. '"')
	endif
endfunc


"----------------------------------------------------------------------
" ask input for cppman
"----------------------------------------------------------------------
function! module#action#cppman() abort
	let t = 'Find word in Cppman:'
	let t = asclib#ui#input(t, module#cpp#fetch_cword(), 'cppman')
	let t = asclib#string#strip(t)
	redraw
	if t != ''
		exec 'Cppman ' . t
	endif
endfunc



