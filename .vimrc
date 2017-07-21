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
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'itchyny/vim-gitbranch'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'Yggdroot/indentLine'

call neobundle#end()

" restore cursor location
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal! g'\"" |
\ endif

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

autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

syntax on
colorscheme dracula
highlight CursorLine ctermfg=none ctermbg=52 cterm=none
highlight Comment ctermfg=156 ctermbg=none

