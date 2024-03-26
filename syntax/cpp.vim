
if get(g:, 'colors_name', '') == 'borland256'
	syntax match cMark2 '('
	syntax match cMark2 ')'
	syntax match cMark2 '{'
	syntax match cMark2 '}'
	hi! def link cMark2 Statement
endif



