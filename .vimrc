" for neobundle
set nocompatible
filetype off
set rtp+=$HOME/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'vim-scripts/Wombat'
NeoBundle 'dracula/vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tomasr/molokai'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'cohama/lexima.vim'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'itchyny/vim-gitbranch'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'fatih/vim-go'
NeoBundle 'othree/yajs.vim'
NeoBundle 'posva/vim-vue'

call neobundle#end()
NeoBundleCheck

" restore cursor location
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal! g'\"" |
\ endif
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

" show branch on lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

" autoremove the trailing spaces
autocmd BufWritePre * :FixWhitespace

" for lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

set encoding=utf-8
set fenc=utf-8
set paste
set backspace=start,eol,indent
set whichwrap=b,s,[,],<,>,~
set mouse=
set t_vb=
set novisualbell
set laststatus=2
set statusline=%F%r%h%=
set number
set cursorline
set incsearch
set ignorecase
set wrapscan
set gdefault
set wildmenu wildmode=list:full
set smartcase
set smarttab
set hlsearch
set showmatch
set noshowmode
set autoread
set noswapfile
set colorcolumn=80

set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set expandtab

filetype plugin on
autocmd BufRead,BufNewFile *.py setfiletype python
autocmd BufRead,BufNewFile *.go setfiletype go

syntax on
colorscheme dracula
highlight CursorLine ctermfg=none ctermbg=52 cterm=none
highlight Comment ctermfg=156 ctermbg=none

inoremap <C-c> <esc>
