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

	hi DiffAdd guifg=#a0a0a0 guibg=#447555 guisp=#447555 gui=NONE
	hi DiffChange guifg=#808080 guibg=#3f3b73 guisp=#3f3b73 gui=NONE
	hi DiffDelete guifg=#554253 guibg=#554253 guisp=NONE gui=NONE
	hi DiffText guifg=#e0e0e0 guibg=#5e58ad guisp=#5e58ad gui=NONE

	if str2nr(&t_Co) >= 16
		hi! Comment ctermfg=Yellow ctermbg=NONE cterm=NONE
		hi! LineNr cterm=NONE cterm=NONE ctermfg=Yellow ctermbg=NONE
		hi! Cursor cterm=NONE ctermfg=Black ctermbg=Cyan
		hi! CursorLineNr cterm=NONE ctermfg=DarkYellow ctermbg=NONE
		hi! TabLine ctermbg=DarkGrey ctermfg=DarkCyan
		hi! TabLineFill ctermbg=DarkGrey ctermfg=DarkCyan
		hi! TabLineSel ctermbg=LightGrey ctermfg=Black

		highlight DiffAdd    cterm=NONE ctermfg=Yellow ctermbg=Cyan
		highlight DiffDelete cterm=NONE ctermfg=DarkBlue ctermbg=DarkBlue
		highlight DiffChange cterm=NONE ctermfg=Black ctermbg=Green
		highlight DiffText   cterm=NONE ctermfg=White ctermbg=DarkYellow
	endif
else
	hi! SignColumn ctermbg=NONE
	hi! LineNr guifg=#93a1a1 guisp=NONE guibg=NONE
	hi! TabLineSel guifg=#fdf6e3 guibg=#657b83 guisp=NONE gui=reverse
	hi! Terminal ctermbg=NONE

	hi DiffAdd guifg=#6d6d6d guibg=#a5d5a4 guisp=#a5d5a4 gui=NONE
	hi DiffChange guifg=#d0d0d0 guibg=#635b87 guisp=#635b87 gui=NONE
	hi DiffDelete guifg=#ad8f96 guibg=#ad8f96 guisp=NONE gui=NONE
	hi DiffText guifg=#f0f0f0 guibg=#927ec8 guisp=#927ec8 gui=NONE

	if str2nr(&t_Co) >= 16
		hi! Comment ctermfg=Cyan ctermbg=NONE cterm=NONE
		hi! LineNr cterm=NONE cterm=NONE ctermfg=Cyan ctermbg=NONE
		hi! Cursor cterm=NONE ctermfg=Black ctermbg=Cyan
		hi! CursorLineNr cterm=NONE ctermfg=DarkBlue ctermbg=NONE
		hi! TabLine ctermbg=DarkGrey ctermfg=DarkCyan
		hi! TabLineFill ctermbg=DarkGrey ctermfg=DarkCyan
		hi! TabLineSel ctermbg=LightGrey ctermfg=Black
		hi! Visual ctermfg=2 ctermbg=15 cterm=reverse

		highlight DiffAdd    cterm=NONE ctermfg=Grey ctermbg=Cyan
		highlight DiffDelete cterm=NONE ctermfg=DarkBlue ctermbg=DarkBlue
		highlight DiffChange cterm=NONE ctermfg=Black ctermbg=Green
		highlight DiffText   cterm=NONE ctermfg=White ctermbg=DarkYellow
	endif

	if str2nr(&t_Co) >= 256
		hi! Visual ctermfg=252 ctermbg=230 cterm=reverse
	elseif str2nr(&t_Co) >= 16
		hi! Visual ctermfg=2 ctermbg=15 cterm=reverse
	endif
endif
