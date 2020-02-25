" This is another test

" pathogen stuff - allows me to put vim files somewhere outside of ~/.vim
" so that I can store them (bitbucket or otherwise) and keep the synced
" between machines
"
filetype off				"  Good idea to set this before calling pathogen
call plug#begin('~/vimfiles/plugins')
" all plugins
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git',
Plug 'https://github.com/elzr/vim-json.git',
Plug 'git://github.com/AndrewRadev/linediff.vim.git',
Plug 'https://github.com/henrik/vim-indexed-search.git',
Plug 'https://github.com/tpope/vim-markdown.git',
Plug 'https://github.com/vim-airline/vim-airline.git',
Plug 'https://github.com/vim-airline/vim-airline-themes.git',
Plug 'git://github.com/tmux-plugins/vim-tmux.git',
Plug 'git://github.com/craigemery/vim-autotag.git',
Plug 'https://github.com/lifepillar/vim-solarized8.git',
Plug 'https://github.com/editorconfig/editorconfig-vim.git',
Plug 'https://gitlab.com/code-stats/code-stats-vim.git'

" on demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'https://github.com/fatih/vim-go.git', { 'for': 'go' }
call plug#end()

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
	set guifont=Input
	set lines=55 columns=160
	set bg=dark
	colorscheme solarized
endi

" change the leader to be something a little easier
let mapleader=","
"
" " set xml folding
let g:xml_syntax_folding=1

function! CopyVimRC()
   silent let f = system("u:/copyvim.bat")
endfunction

" settings allowing easier work with .vimrc
augroup _vimrc
   autocmd!
   autocmd bufwritepost vimrc call CopyVimRC() | source $MYVIMRC
augroup end

augroup _vsvimrc
   autocmd!
   autocmd bufwritepost vsvimrc call CopyVimRC()
augroup end

nmap <leader>v :vsplit $MYVIMRC<CR>

map <leader>x :set filetype=xml<CR> 

" Tab settings
set tabstop=4				" tab width of 4
set shiftwidth=4			" shift width of 4
set softtabstop=4			" backspace removes 4 spaces

if exists ('g:vsvim_useeditordefaults')
   set vsvim_useeditordefaults
endif

let g:vim_json_syntax_conceal = 0

set mouse=a

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

" Code stats
"let g:codestats_api_key = 'SFMyNTY.WVd4c1pXNWtaWEk9IyNNekE9.ri-dvVrlAjzNNHOec_IVNnYGo_WgiLruzRLb4wKwn1Y'
" let g:codestats_api_url = 'https://beta.codestats.net'
let g:codestats_api_key = 'SFMyNTY.WVd4c1pXNWtaWEk9IyNPRGszTVE9PQ.bQrRQ-FLtF_IcqDEab65PYWB5aVvNikaMc4K-b3dtk4'

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
   let status = ''
   if exists ("*P4RulerStatus")
      let status = P4RulerStatus()
   endif
   return status
endfunction

function! SetAirlineErrors()
   " change if trailing spaces and mixed indentation is set based on filetype
   " let ft = &filetype
   " if ft == 'text'
   "    let g:airline#extensions#whitespace#show_message = 0
   " else
   "    let g:airline#extensions#whitespace#show_message = 1
   " endif
endfunction

" set up some autocmds to deal with airline settings for different kinds of buffers
augroup setairlineerrors
   autocmd!
   autocmd BufEnter * call SetAirlineErrors()
augroup END

"call airline#parts#define_function( 'perforce', 'GetPerforceStatus' )
"call airline#parts#define_accent( 'perforce', 'red' )

"let g:airline_section_x=airline#section#create( ['perforce', ' ', 'filetype'] )
" let g:airline_section_z=airline#section#create( ['[%l/%L,%v][%p%%]'] )
let g:airline#extensions#whitespace#show_message = 0
let g:airline#extension#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 0
let g:airline_section_x=airline#section#create( ['filetype', ' ', '%{CodeStatsXp()}'] )

