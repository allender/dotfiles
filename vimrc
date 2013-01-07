" pathogen stuff - allows me to put vim files somewhere outside of ~/.vim
" so that I can store them (bitbucket or otherwise) and keep the synced
" between machines
"
filetype off				"  Good idea to set this before calling pathogen
call pathogen#infect()
filetype plugin indent on

set nocompatible			" No need to be compatible with VI anymore
syntax on

set bg=dark
colorscheme solarized

" if no gui and win32, then set better colorscheme that doesn't
" mess up from dos prompt
if has("win32")
    echo "blahblah"
endif

" change the leader to be something a little easier
let mapleader=","

" settings allowing easier work with .vimrc
if has ("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
endif
nmap <leader>v :vsplit $MYVIMRC<CR>

" Tab settings
set tabstop=4				" tab width of 4
set shiftwidth=4			" shift width of 4
set softtabstop=4			" backspace removes 4 spaces
set expandtab				" always use spaces and not tabs

set mouse=a

" have a different status line so that ruler can be shown on the left instead of far right which is annoying on widescreen monitors 
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l/%L,%v][%p%%]

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

nnoremap / /\v
vnoremap / /\v
nnoremap <leader>/ :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" prevent help from opening on accident when reaching for ESC key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" other useful mappings