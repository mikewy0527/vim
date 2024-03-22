"======================================================================
"
" terminal.vim - terminal buffers
"
" Created by skywind on 2024/03/23
" Last Modified: 2024/03/23 00:37:07
"
"======================================================================

unsilent echom "t1"
if &bt != 'terminal'
	unsilent echom "t2"
	finish
elseif !exists('b:asyncrun_cmd')
	unsilent echom "t3"
	finish
endif

unsilent echom "t4"
exec printf('nnoremap <buffer>q :<c-u>close<cr>')
exec printf('nnoremap <buffer><m-x> :<c-u>close<cr>')
exec printf('nnoremap <buffer><tab>q :<c-u>close<cr>')

let b:matchup_matchparen_enabled = 0

if exists(':NoMatchParen') == 2
	exec 'NoMatchParen'
endif


