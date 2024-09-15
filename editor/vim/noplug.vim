" vim configuratio with no plugin
" @Reference: https://gitee.com/mirrorvim/vim-fast/blob/master/vimrc-no-plug
" @Reference: https://github.com/chenxuan520/vim-fast
" @Reference: https://github.com/skywind3000/vim-init

" General
let mapleader='\'
let maplocalleader=' '
filetype on
filetype plugin on
set noeb
syntax enable
syntax on
set t_Co=256
set vb t_vb=
set cmdheight=1
set showcmd
set textwidth=0
set ruler
set showtabline=2
set laststatus=2
set number
set relativenumber
set cursorline
set cursorcolumn
set colorcolumn=80
set whichwrap+=<,>,h,l
set ttimeoutlen=0
set virtualedit=block,onemore
set showmode
set hidden
set matchpairs+=<:>
set background=dark
set splitbelow
set splitright
set clipboard^=unnamed,unnamedplus

" Theme
colorscheme retrobox

" Indent
set autoindent
set cindent
set cinoptions=g0,:0,N-s,(0
set smartindent
filetype indent on
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set nowrap
set backspace=2
set sidescroll=4
set nofoldenable
set list lcs=tab:│\ 
set sidescroll=0
set sidescrolloff=4
set scrolloff=2

" Completion
set wildmenu
set completeopt=menuone,preview,noselect
set omnifunc=syntaxcomplete#Complete
set shortmess+=c
set cpt+=kspell

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Cache
set nobackup
set noswapfile
set autoread
set autowrite
set confirm

" File Encoding
set langmenu=en_US.UTF-8
set helplang=en
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

" gvim/macvim
if has('gui_running')
  set guifont=JetBrainsMono\ Nerd\ Font\ Regular\ 14
  set guioptions-=m
  set guioptions-=T
  set guioptions-=L
  set guioptions-=r
  set guioptions-=b
  set showtabline=0
  set guicursor=n-v-c:ver5
endif

" auto command
autocmd BufReadPost * if line("'\"")>1 && line("'\"") <= line('$') | exe "normal! g'\"" | endif
autocmd BufReadPost,InsertEnter * setlocal formatoptions-=r formatoptions-=c formatoptions-=o
autocmd BufWinEnter * if getfsize(expand('%')) > 1048576 | syntax clear | endif

" Edit and Reload .vimrc
nnoremap <leader>rc <CMD>edit $MYVIMRC<CR>
nnoremap <leader>rC <CMD>source $MYVIMRC<CR>

" Disable distribution plugins
let g:loaded_getscriptPlugin=1
let g:loaded_gzip=1
let g:loaded_logiPat=1
let g:loaded_manpager=1
" let g:loaded_matchparen=1
" let g:loaded_netrwPlugin=1
let g:loaded_rrhelper=1
let g:loaded_spellfile=1
let g:loaded_tarPlugin=1
let g:loaded_tohtml=1
let g:loaded_vimballPlugin=1
let g:loaded_zipPlugin=1

" Map jk to <Esc>
inoremap jk <ESC>

" Move under insert mode
imap <C-n> <DOWN>
imap <C-p> <UP>
imap <C-f> <RIGHT>
imap <C-b> <LEFT>
inoremap <C-a> <C-o>^
inoremap <C-e> <END>

" Move under command mode
cnoremap <C-a> <HOME>
cnoremap <C-e> <END>
cnoremap <C-d> <DEL>
cnoremap <C-b> <LEFT>
cnoremap <C-f> <RIGHT>

" Change window
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" auto-paris
let g:pair_map={
      \ '(': ')',
      \ '[': ']',
      \ '{': '}',
      \ '"': '"',
      \ "'": "'",
      \ '<': '>',
      \ '`': '`'
      \ }
function! s:Judge(ch, mode)
  if a:mode!='c'
    let ch=getline('.')[col('.')-1]
  else
    let ch=getcmdline()[getcmdpos()-1]
  endif
  if (a:ch=='"')||(a:ch=="'")||(a:ch=='`')
    if ch!=a:ch
      return a:ch.a:ch."\<left>"
    endif
  endif
  if ch==a:ch
    return "\<right>"
  endif
  return a:ch
endfunc
function! s:Backspace(mode)
  if a:mode!='c'
    let s:pair=getline('.')[col('.')-1]
    let s:pair_l=getline('.')[col('.')-2]
  else
    let s:pair=getcmdline()[getcmdpos()-1]
    let s:pair_l=getcmdline()[getcmdpos()-2]
  endif
  if has_key(g:pair_map, s:pair_l)&&(g:pair_map[s:pair_l]==s:pair)
    return "\<right>\<bs>\<bs>"
  else
    return "\<bs>"
  endif
endfunc
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
cnoremap ( ()<LEFT>
cnoremap [ []<LEFT>
cnoremap { {}<LEFT>
inoremap <EXPR><SILENT>" <SID>Judge('"', 'i')
inoremap <EXPR><SILENT>` <SID>Judge('`', 'i')
inoremap <EXPR><SILENT>' <SID>Judge("'", 'i')
inoremap <EXPR><SILENT>> <SID>Judge('>', 'i')
inoremap <EXPR><SILENT>) <SID>Judge(')', 'i')
inoremap <EXPR><SILENT>} <SID>Judge('}', 'i')
inoremap <EXPR><SILENT>] <SID>Judge(']', 'i')
inoremap <EXPR><BS> <sid>Backspace('i')
cnoremap <EXPR><BS> <sid>Backspace('c')

" StatusLine
function! GetMode()
  let m = mode()
  let s:str=''
  let s:ctermfgcolor='109'
  if m == 'R'
    let s:ctermfgcolor='214'
    let s:str= 'REPLACE '
  elseif m == 'v'
    let s:ctermfgcolor='208'
    let s:str= 'VISUAL '
  elseif m == 'i'
    let s:ctermfgcolor='167'
    let s:str= 'INSERT '
  elseif m == 't'
    let s:ctermfgcolor='175'
    let s:str= 'TERMINAL '
  else
    let s:ctermfgcolor='142'
    let s:str= 'NORMAL '
  endif
  exec 'highlight User3 ctermbg='.s:ctermfgcolor.' ctermfg=234'
  exec 'highlight User4 ctermbg=234 ctermfg='.s:ctermfgcolor
  redraw
  return s:str
endfunction
set statusline=%3*\ %{GetMode()}
set statusline+=%4*\ %F\ %h%m%r%w%=
set statusline+=%4*\ %Y
set statusline+=%4*\ [%{&fileencoding}]
set statusline+=%4*\ %l\:%c\ %p%%\ 

" TabLine
let s:tab_after=''
func! TabLine(direct)
  let s:tab_result=''
  let flag=0
  if a:direct
    return s:tab_after!=''?s:tab_after.'|':"\ "
  else
    let s:tab_after=''
  endif
  for buf in getbufinfo({'buflisted': 1})
    let s:name=buf.name
    if strridx(buf.name, '/')!=-1
      let s:name=strpart(buf.name, strridx(buf.name,'/')+1)
    endif
    if buf.name!=expand('%:p')
      let bt=getbufvar(buf.bufnr, '&buftype')
      if bt!=''
        continue
      endif
      if flag==0
        let s:tab_result=s:tab_result."\ ".s:name."\ "
      else
        let s:tab_after=s:tab_after."\ ".s:name."\ "
      endif
    else
      let flag=1
    endif
  endfor
  redrawt
  return s:tab_result
endfunc
function! TabLineSet()
  if len(gettabinfo())>1
    return "%5* Tab %2*%=%1* BUFFER"
  endif
  if &modified
    let tab="%2* %0.32(%{TabLine(0)}%)%5*\ %t\ %6*%2*%<%{TabLine(1)}%r%h%w%=%6*\ %5* BUFFER\ "
  else
    let tab="%2* %0.32(%{TabLine(0)}%)%1*\ %t\ %2*%2*%<%{TabLine(1)}%r%h%w%=%2*\ %1* BUFFER\ "
  endif
  return tab
endfunc
set tabline=%!TabLineSet()
highlight User1 ctermbg=142 ctermfg=234
highlight User2 ctermbg=234 ctermfg=230
highlight User5 ctermbg=142 ctermfg=234

" netrw
let g:netrw_banner=0
let g:netrw_browse_split=0
let g:netrw_winsize=15
nnoremap <C-n> <CMD>Lexplore<CR>
