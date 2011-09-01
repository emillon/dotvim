set nocp
colo molokai
filetype plugin on
filetype indent on
syntax enable
set expandtab
set autoindent
set encoding=utf8
"set cindent
"set smartindent
set smarttab
set tw=80
set mouse=a
set softtabstop=2
set shiftwidth=2

set backupdir=~/.vim/backup
set directory=~/.vim/swap

set ignorecase
set smartcase

call pathogen#infect()

"" <Leader> is ,

let mapleader=","

"" open file in same directory as current file
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>

"" i dont like arrows

imap <c-up>     <Nop>
imap <c-down>   <Nop>
imap <c-left>   <Nop>
imap <c-right>  <Nop>
map  <c-up>     <Nop>
map  <c-down>   <Nop>
map  <c-left>   <Nop>
map  <c-right>  <Nop>

imap <up>       <Nop>
imap <down>     <Nop>
imap <left>     <Nop>
imap <right>    <Nop>
map  <up>       <Nop>
map  <down>     <Nop>
map  <left>     <Nop>
map  <right>    <Nop>

imap <pageup>   <nop>
imap <pagedown> <nop>
imap <home>     <nop>
imap <end>      <nop>
map  <pageup>   <nop>
map  <pagedown> <nop>
map  <home>     <nop>
map  <end>      <nop>

imap <del>      <nop>
imap <c-del>    <nop>
imap <m-del>    <nop>
map  <del>      <nop>
map  <c-del>    <nop>
map  <m-del>    <nop>

imap <c-pageup>     <nop>
imap <c-pagedown>   <nop>
map  <c-pageup>     <nop>
map  <c-pagedown>   <nop>

"" K is useless...
"map K <nop>

"" and so is F1
map <F1> <nop>

"" Vala stuff
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala

"" hide objects in netrw view

let g:netrw_hide=1
let g:netrw_list_hide='.*\.cm[iox]$,\.o$,\.swp,^.*\.pyc$'
let g:netrw_sort_sequence= '[\/]$,*,\.ml,\.mli,\.bak$,\.o$,\.h$,\.info$,\.swp$,\.obj$'

set wildignore=*.o,*.cmx,*.cmo,*.cmi

set title
set modeline

let g:user_zen_settings = {'mkd' : { 'extends' : 'html' }, 'mdwn' : { 'extends' : 'html' } }

:ab µforall ∀

:ab µ~> ↝
:ab µts ⊢

:ab µtrans ⇥

:ab µsq □

:ab µem —

:ab µnotin ∉

"highlight EndSpaces ctermbg=green guibg=green
"match EndSpaces /\s\+$/

map <leader>p :!pandoc -t latex<CR>

map <leader>h1 yypVr=o<CR><Esc>
map <leader>h2 yypVr-o<CR><Esc>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

autocmd BufEnter *.mdwn set filetype=pdc

set laststatus=2
set statusline=%t\ %y\ [%l,%c]\ [%p%%]\ %{fugitive#statusline()}

" b.d.o mdwn link
map <leader>bdo yawi[$a](http://bugs.debian.org/pa)

au BufRead,BufNewFile *.mako            setfiletype mako

" Python

au BufRead,BufNewFile *.py     set sw=4
au BufRead,BufNewFile *.py     set sts=4

autocmd FileType python compiler pylint
let g:pylint_onwrite = 0

" list

set listchars=tab:▸\ ,eol:¬,trail:☠
nmap <leader>l :set list!<CR>

" unicode separator
set fillchars=vert:│

" unicode box

nmap <leader>box VypVr═yykkpI╔ji║ji╚kk$a╗ja║ja╝^j
nmap <leader>sbox VypVr─yykkpI╭ji│ji╰kk$a╮ja│ja╯^j

nmap <F12> :set paste!<CR>

map <F2> :mksession! ~/.vim_session <cr> " Quick write session with F2
map <F3> :source ~/.vim_session <cr>     " And load session with F3

set showbreak=↪

set hls
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" http://www.reddit.com/r/vim/comments/gexi6/
hi StatColor guibg=#95e454 guifg=black ctermbg=lightgreen ctermfg=black
hi Modified guibg=orange guifg=black ctermbg=lightred ctermfg=black

function! MyStatusLine(mode)
    let statusline=""
    if a:mode == 'Enter'
        let statusline.="%#StatColor#"
    endif
    let statusline.="\(%n\)\ %f\ "
    if a:mode == 'Enter'
        let statusline.="%*"
    endif
    let statusline.="%#Modified#%m"
    if a:mode == 'Leave'
        let statusline.="%*%r"
    elseif a:mode == 'Enter'
        let statusline.="%r%*"
    endif
    let statusline .= "\ (%l/%L,\ %c)\ %P%=%h%w\ %y\ [%{&encoding}:%{&fileformat}]\ \ "
    return statusline
endfunction

au WinEnter * setlocal statusline=%!MyStatusLine('Enter')
au WinLeave * setlocal statusline=%!MyStatusLine('Leave')
set statusline=%!MyStatusLine('Enter')

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi StatColor guibg=orange ctermbg=lightred
  elseif a:mode == 'r'
    hi StatColor guibg=#e454ba ctermbg=magenta
  elseif a:mode == 'v'
    hi StatColor guibg=#e454ba ctermbg=magenta
  else
    hi StatColor guibg=red ctermbg=red
  endif
endfunction 

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi StatColor guibg=#95e454 guifg=black ctermbg=lightgreen ctermfg=black
" /status

set virtualedit+=block

au BufRead,BufNewFile *.c     set sw=4
au BufRead,BufNewFile *.c     set sts=4

nmap + zo
nmap - zc

au BufRead,BufNewFile *.mail setfiletype mail

au BufRead,BufNewFile *.asm set syntax=nasm

set foldmethod=marker

set printoptions+=syntax:y,header:0
