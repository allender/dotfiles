let s:save_cpo = &cpo

if !exists( 'g:lovedocs_loaded' )
	finish
endif
let g:lovedocs_loaded = 1

if !exists( 'g:lovedocs_colors' )
	let g:lovedocs_colors = 'guifg=#ff60e2 ctermfg=206'
endif

" Reset compatibility
let &cpo = s:save_cpo
