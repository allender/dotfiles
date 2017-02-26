
" pathogen stuff - allows me to put vim files somewhere outside of ~/.vim
" so that I can store them (bitbucket or otherwise) and keep the synced
" between machines
"
filetype off				"  Good idea to set this before calling pathogen
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

set nocompatible			" No need to be compatible with VI anymore
syntax on

" set the swap directory to some tmp folder
if has("win32") || has("win64")
    set directory=$TMP
else
    set directory=/tmp
end

" set num colors appropriately for gui vs not
if has('gui_running')
   let g:solarized_termcolors=256
else
   let g:solarized_termcolors=16
endi

set bg=dark
colorscheme solarized

" change the leader to be something a little easier
let mapleader=","
"
" " set xml folding
let g:xml_syntax_folding=1

" for you complete me
let g:ycm_confirm_extra_conf = 0

function! CopyVimRC()
   silent let f = system("u:/copyvim.bat")
endfunction

" settings allowing easier work with .vimrc
augroup _vimrc
   autocmd!
   autocmd bufwritepost vimrc call CopyVimRC() | source $MYVIMRC
augroup end

nmap <leader>v :vsplit $MYVIMRC<CR>

map <leader>x :set filetype=xml<CR> 

" Tab settings
set tabstop=4				" tab width of 4
set shiftwidth=4			" shift width of 4
set softtabstop=4			" backspace removes 4 spaces
set expandtab				" always use spaces and not tabs

if exists ('g:vsvim_useeditordefaults')
   set vsvim_useeditordefaults
endif

let g:vim_json_syntax_conceal = 0

set mouse=a

" have a different status line so that ruler can be shown on the left instead of far right which is annoying on widescreen monitors
"set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l/%L,%v][%p%%]

" setup autocmd to change the statusline since it
" depends on a plugin
"autocmd VimEnter * if exists ("*P4RulerStatus") | set statusline+=%=%{P4RulerStatus()} | endif

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
"set cursorline             " adds a line underlining the line where your cursor is  I found this annoying
set ttyfast
set backspace=indent,eol,start
set laststatus=2
set number
" set undofile                " undofile allows undoing even after saving a file

set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" line wrapping
set wrap
"set textwidth=79           " I don't like this option either.  I'd like my lines to be as long as I want them
set formatoptions=qrn1

" setting for tags
set tags=tags;/

nnoremap / /\v
vnoremap / /\v
nnoremap <leader>/ :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" prevent help from opening on accident when reaching for ESC key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" fold settings
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> za

" Perforce settings
nnoremap <leader>pi :call P4Info()<cr>
nnoremap <leader>pf :call P4Fstat()<cr>
nnoremap <leader>po :call P4Edit()<cr>
nnoremap <leader>pa :call P4Add()<cr>
nnoremap <leader>pd :call P4Diff()<cr>

" Linediff settings
noremap <leader>ldt :Linediff<CR>
noremap <leader>ldo :LinediffReset<CR>

" NERDTree settings
nnoremap <leader>nt :NERDTree d:\projects<cr>
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" other useful mappings
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

"airline setup for better support of status line.
function! GetPerforceStatus()
   let a:status = ''
   if exists ("*P4RulerStatus")
      let a:status = P4RulerStatus()
   endif
   return a:status
endfunction

function! SetAirlineErrors()
   " change if trailing spaces and mixed indentation is set based on filetype
   let a:ft = &filetype
   if a:ft == 'text'
      let g:airline#extensions#whitespace#show_message = 0
   else
      let g:airline#extensions#whitespace#show_message = 1
   endif
endfunction

call airline#parts#define_function( 'perforce', 'GetPerforceStatus' )
call airline#parts#define_accent( 'perforce', 'red' )

let g:airline_section_x=airline#section#create( ['perforce', ' ', 'filetype'] )
"let g:airline_section_z=airline#section#create( ['[%l/%L,%v][%p%%]'] )
let g:airline#extension#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 0

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
 
" set up some autocmds to deal with airline settings for different kinds of buffers
augroup setairlineerrors
   autocmd!
   autocmd BufEnter * call SetAirlineErrors()
augroup END


