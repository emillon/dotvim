filetype off
call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-speeddating'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'rust-lang/rust.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'Lokaltog/vim-easymotion'
Plug 'blue-prawn/ocp-build-vim-syntax'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'scrooloose/syntastic'
Plug 'chase/vim-ansible-yaml'
Plug 'lepture/vim-jinja'
Plug 'tfnico/vim-gradle'
Plug 'Shutnik/jshint2.vim'
Plug 'godlygeek/tabular'
Plug 'ElmCast/elm-vim'
Plug 'let-def/ocp-indent-vim'
Plug 'rgrinberg/vim-ocaml'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-unimpaired'
Plug 'vito-c/jq.vim'
Plug 'posva/vim-vue'
Plug 'janko-m/vim-test'
Plug 'tsiemens/vim-aftercolors'
Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'
Plug 'rr-/vim-hexdec'
Plug 'sbdchd/neoformat'
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-emoji'
Plug 'brianclements/vim-lilypond'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-markdown'
Plug 'airblade/vim-gitgutter'
Plug 'MagnusS/okra'
Plug 'kisom/eink.vim'
call plug#end()
syntax enable

let g:snipMate = { 'snippet_version' : 1 }

let g:opamshare = substitute(system('opam var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
let g:syntastic_ocaml_checkers = ['merlin']

let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

autocmd BufRead,BufNewFile ~/src/okr-updates/* let g:syntastic_markdown_checkers = ['okra']
autocmd BufRead,BufNewFile ~/src/tarides-admin/* let g:syntastic_markdown_checkers = ['okra']

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
set nomodeline
set wildmenu

set guioptions=
set guicursor=a:blinkon0
set guifont=Fira\ Code\ 15

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
inoremap <A-Space> <Space>
"}}}
" Open file in same directory as current file {{{
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
" }}}
" Nops (etc) {{{
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
set wildignore+=*.prof
set wildignore+=node_modules
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

" search for visually hightlighted text
vnoremap <leader>r y<ESC>/\V<c-r>"<CR>

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

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>

nnoremap <silent> <C-p> :GFiles<CR>

inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /home/etienne/.okrs')
