"  set filetypes based on extensions that are commonly used
if exists( "did_load_filetypes" )
   finish
endif

augroup filetypedetect
   au! BufRead,BufNewFile *.vsex    setfiletype xml
   au! BufRead,BufNewFile *.vse     setfiletype json 
augroup END

augroup cc
    autocmd FileType c,cpp,cc set colorcolumn=80
augroup END
