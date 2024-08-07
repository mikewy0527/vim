"======================================================================
"
" solarized.vim - color patch for solarized
"
" Created by skywind on 2024/08/06
" Last Modified: 2024/08/06 11:01:20
"
"======================================================================

" setting background transparency
hi! Normal ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi! NonText ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE

if &background == 'dark'
	hi! LineNr guifg=#586e75 guisp=NONE guibg=NONE
	hi! TabLineSel guifg=#002b36 guibg=#839496 guisp=NONE gui=reverse

	if str2nr(&t_Co) >= 16
		hi! Comment ctermfg=Yellow ctermbg=NONE cterm=NONE
		hi! LineNr term=bold cterm=NONE ctermfg=Yellow ctermbg=NONE
		hi! Cursor cterm=NONE ctermfg=Black ctermbg=Cyan
		hi! CursorLineNr cterm=NONE ctermfg=DarkYellow ctermbg=NONE
		hi! TabLine ctermbg=DarkGrey ctermfg=DarkCyan
		hi! TabLineFill ctermbg=DarkGrey ctermfg=DarkCyan
		hi! TabLineSel ctermbg=LightGrey ctermfg=Black
	endif
else
	hi! SignColumn ctermbg=NONE
	hi! LineNr guifg=#93a1a1 guisp=NONE guibg=NONE
	hi! TabLineSel guifg=#fdf6e3 guibg=#657b83 guisp=NONE gui=reverse

	if str2nr(&t_Co) >= 16
		hi! Comment ctermfg=Cyan ctermbg=NONE cterm=NONE
		hi! LineNr term=bold cterm=NONE ctermfg=Cyan ctermbg=NONE
		hi! Cursor cterm=NONE ctermfg=Black ctermbg=Cyan
		hi! CursorLineNr cterm=NONE ctermfg=DarkBlue ctermbg=NONE
		hi! TabLine ctermbg=DarkGrey ctermfg=DarkGrey
		hi! TabLineFill ctermbg=DarkGrey ctermfg=DarkGrey
		hi! TabLineSel ctermbg=LightGrey ctermfg=Black
		hi! Visual ctermfg=2 ctermbg=15 cterm=reverse
	endif

	if str2nr(&t_Co) >= 256
		hi! Visual ctermfg=252 ctermbg=230 cterm=reverse
	elseif str2nr(&t_Co) >= 16
		hi! Visual ctermfg=2 ctermbg=15 cterm=reverse
	endif
endif
