setl sw=4 ts=4 sts=4 noet

function! _goimports()
  exe ":silent !goimports -w %:p"
endfunction

command! GoImports call _goimports()

augroup goimports
  autocmd!
  autocmd bufWritePost *.go :GoImports
augroup END
