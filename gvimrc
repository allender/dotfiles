"  GUI information for VIM
"

if has( "Win32" ) 
    set guifont=Consolas:h10
else
    set guifont=Inconsolata:H11
endif

" go with standard style vim dialogs
set guioptions+=c

" come up with better default rows/columns
set lines=55 columns=120
