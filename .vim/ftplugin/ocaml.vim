setlocal sw=2
map <buffer> <LocalLeader>y :MerlinYankLatestType<return>
nmap <LocalLeader>r <Plug>(MerlinRename)

function! ExtractLocalOpen()
    let mod = expand("<cword>")
    execute "normal! Vap\<esc>"
    execute "'<,'>s/" . mod. "\.//g"
    '<
    execute "normal! olet open " . mod . " in\<esc>"
endfunction

nmap <LocalLeader>o :call ExtractLocalOpen()<cr>

function! ExtractLocalVar()
    call inputsave()
    let var = input('Variable name: ')
    call inputrestore()
    execute "normal! gvxOlet " . var . " = \<esc>pa in\<esc>`<i" . var
endfunction

vmap <LocalLeader>x :call ExtractLocalVar()<cr>

" dune
nmap <LocalLeader>dt :! dune runtest<cr>
nmap <LocalLeader>dp :! dune promote<cr>
nmap <LocalLeader>db :! dune build<cr>

"let g:neoformat_enabled_ocaml = []
"augroup fmt
"    autocmd!
"    autocmd BufWritePre * undojoin | Neoformat
"augroup END
nmap <LocalLeader>f :Neoformat ocamlformat<cr>
