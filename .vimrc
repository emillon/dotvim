filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'tomasr/molokai'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jceb/vim-orgmode'
Plugin 'tpope/vim-fugitive'
Plugin 'rust-lang/rust.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mintplant/vim-literate-coffeescript'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'blue-prawn/ocp-build-vim-syntax'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
call vundle#end()
filetype plugin on
filetype indent on
syntax enable


" Colors
set background=dark
colo molokai
if g:colors_name == "molokai"
  let g:vimroom_ctermbackground = 233
  let g:vimroom_guibackground = 233
endif

" Indent, etc
set expandtab
set nojoinspaces
set encoding=utf8
set smarttab
set textwidth=80
set mouse=a
set softtabstop=4
set shiftwidth=4
set title
set modeline
set wildmenu

set guioptions=
set guicursor=a:blinkon0
set guifont=Inconsolata\ Medium\ 12

set backupdir=~/.vim/backup
set directory=~/.vim/swap

if has('xterm_clipboard') && has('unnamedplus')
  set clipboard=unnamed,unnamedplus,exclude:cons\|linux
endif

set showcmd
set lazyredraw

" Search {{{
set ignorecase
set smartcase
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
"}}}
" Key bindings {{{
" General key bindings {{{
let mapleader=","
let maplocalleader=","
map <F2> :mksession! ~/.vim_session <cr> " Quick write session with F2
map <F3> :source ~/.vim_session <cr>     " And load session with F3
set pastetoggle=<F12>
inoremap jk <esc>
inoremap <esc> <nop>
inoremap <A-Space> <Space>
"}}}
" Open file in same directory as current file {{{
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
" }}}
" Nops (arrows etc) {{{

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

map K <nop>
map <F1> <nop>
" }}}
" Unicode abbreviations {{{

ab µforall ∀
ab µ~> ↝
ab µts ⊢
ab µtrans ⇥
ab µsq □
ab µem —
ab µnotin ∉

"}}}
" Switch between interface and implementation {{{
" http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file

function! SwitchSourceHeader()
  if (expand ("%:e") == "ml")
    find %:t:r.mli
  else
    find %:t:r.ml
  endif
endfunction

nmap ,s :call SwitchSourceHeader()<CR>

" }}}
"}}}
" Language support {{{
" Markdown {{{
map <leader>p :!pandoc -t latex<CR>

let g:user_zen_settings = {'mkd' : { 'extends' : 'html' }, 'mdwn' : { 'extends' : 'html' } }

"}}}
" LaTeX {{{
let g:tex_conceal='adgms'

" Section jumps (should probably be an autocmd)
map <silent> ]l :/\\\(sub\)\{,2}section\s*{<CR> :noh<CR>
map <silent> [l :?\\\(sub\)\{,2}section\s*{<CR> :noh<CR>

" }}}
"}}}
" Status line {{{
" Always keep the title
set laststatus=2

" Git status
set statusline=%t\ %y\ [%l,%c]\ [%p%%]\ %{fugitive#statusline()}
" Status line with mode indicator {{{
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
"}}}
"}}}
" Folding {{{
set foldmethod=marker
nmap + zo
nmap - zc
"}}}
" File navigation {{{
"" Hide objects in netrw view
let g:netrw_hide=1
let g:netrw_list_hide='\.cm[ioxp]$,\.o$,\.swp$,\.pyc$,\.hi$'
let g:netrw_sort_sequence= '[\/]$,*,\.ml,\.mli,\.bak$,\.o$,\.h$,\.info$,\.swp$,\.obj$'

set wildignore=*.o
set wildignore+=*.cmx,*.cmo,*.cmi
set wildignore+=*.hi
" }}}
" 'Long' shortcuts {{{

" Unicode boxes
nnoremap <leader>box VypVr═yykkpI╔ji║ji╚kk$a╗ja║ja╝^j
nnoremap <leader>sbox VypVr─yykkpI╭ji│ji╰kk$a╮ja│ja╯^j

" b.d.o mdwn link
map <leader>bdo yawi[$a](http://bugs.debian.org/pa)

map <leader>h1 yypVr=
map <leader>h2 yypVr-

" }}}
" Conceal {{{
if has("gui_running")
  hi Conceal guibg=bg guifg=bg
elseif &t_Co > 16
  hi Conceal ctermbg=bg ctermfg=bg
endif
" }}}

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif


" <leader>l toggles non-printable characters
set listchars=tab:▸\ ,eol:¬,trail:☠,nbsp:~
nmap <leader>l :set list!<CR>

" <leader>ss toggles spellchecker
nmap <leader>ss :set spell!<CR>

" Unicode separator
set fillchars=vert:│
set showbreak=↪

set virtualedit+=block

" Print options
set printoptions+=syntax:y,header:0

" Prevent accidental editing of patch .orig files
autocmd BufRead *.orig set readonly

" Find non-ASCII
nnoremap <leader>a /[^\x00-\x7F]<CR>
