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
function! module#action#tagbar()
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
function! module#action#easymotion(what)
	if a:what != ''
		stopinsert
		call feedkeys("\<Plug>(easymotion-" . a:what . ")", '')
	endif
endfunc


