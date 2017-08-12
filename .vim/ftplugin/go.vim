setl sw=4 ts=4 sts=4 noet

let g:go_bin_path = expand("~/.go/bin")

exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview

nmap <Space>gr <Plug>(go-run)
nmap <Space>gb <Plug>(go-build)
nmap <Space>gt <Plug>(go-test)
nmap <Space>gc <Plug>(go-coverage)
nmap <Space>gd <Plug>(go-doc)
nmap <Space>gi <Plug>(go-import)
nmap <Space>gm <Plug>(go-implements)

let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_functions = 1
let g:go_highlight_build_constraints = 1
