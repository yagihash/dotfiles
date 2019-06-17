" for dein
if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.vim/bundles')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vimが存在していない場合はgithubからclone
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml_dir = expand('~/dotfiles/config/dein')
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup.
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

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
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" autoremove the trailing spaces
autocmd BufWritePre * :FixWhitespace

" for lightline
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ }

" to avoid slow-down caused by vim-vue
let g:vue_disable_pre_processors=1

" supress error messages for vim-go
" let g:go_version_warning = 0
" let g:go_fmt_command = "goimports"
let g:go_null_module_warning = 0

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
set smartindent
set expandtab

filetype plugin on
autocmd BufRead,BufNewFile *.py setfiletype python
autocmd BufNewFile *.py 0r $HOME/.vim/template/python.txt
autocmd BufRead,BufNewFile *.go setfiletype go

colorscheme landscape
highlight CursorLine ctermfg=none ctermbg=52 cterm=none
highlight Comment ctermfg=156 ctermbg=none

inoremap <C-c> <esc>

set autoread
au CursorMoved * checktime
au InsertEnter * checktime

