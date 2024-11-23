""" REFERENCE """
" https://gitee.com/mirrorvim/vim-fast/blob/master/vimrc-no-plug
" https://github.com/chenxuan520/vim-fast

""" GENERAL """
let mapleader='\'
let maplocalleader=' '
filetype on
filetype plugin on
syntax enable
syntax on
set noeb
set t_Co=256
set vb t_vb=
set cmdheight=1
set showcmd
set textwidth=0
set ruler
set showtabline=1
set laststatus=1
set number
set relativenumber
set cursorline
set cursorcolumn
set colorcolumn=80
set whichwrap+=<,>,h,l
set timeoutlen=500
set ttimeoutlen=0
set virtualedit=block
set showmode
set hidden
set matchpairs+=<:>
set splitbelow
set splitright
set clipboard^=unnamed,unnamedplus
set nowrap
set backspace=2
set sidescroll=0
set nofoldenable
set sidescrolloff=4
set scrolloff=2
set complete=.,b,i,w,u,t
set completeopt=menuone,noinsert,noselect,preview
set omnifunc=syntaxcomplete#Complete
set shortmess+=c
set cpt+=kspell
set wildmenu

""" THEME """
set notermguicolors
set background=dark
colorscheme desert

""" INDENTATION """
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

""" SEARCH """
set hlsearch
set incsearch
set ignorecase
set smartcase

""" BACKUP """
set nobackup
set noswapfile
set autoread
set autowrite
set confirm

""" ENCODING """
set langmenu=en_US.UTF-8
set helplang=en
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

""" AUTOCMD """
autocmd BufReadPost * if line("'\"")>1&&line("'\"")<=line('$') | exe "normal! g'\"" | endif
autocmd InsertEnter * setlocal formatoptions-=r formatoptions-=c formatoptions-=o
autocmd BufWinEnter * if getfsize(expand('%'))>1048576 | syntax clear | endif

""" MAPPING """
nnoremap <leader>rc <cmd>edit $MYVIMRC<cr>
nnoremap <leader>rC <cmd>source $MYVIMRC<cr>
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
inoremap jk <esc>
inoremap <c-a> <home>
inoremap <c-e> <end>
cnoremap <c-a> <home>
cnoremap <c-e> <end>

""" NETRW """
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=15
set fillchars=vert:\⎜
nnoremap <c-n> :Lexplore<cr>

""" STATUSLINE """
function! GetMode()
  let s:str=''
  let s:color='88'
  if mode()=='R'
    let s:str='REPLACE '
    let s:color='100'
  elseif mode()=='v'
    let s:str='VISUAL '
    let s:color='130'
  elseif mode()=='i'
    let s:str='INSERT '
    let s:color='88'
  elseif mode()=='t'
    let s:str='TERMINAL '
    let s:color='90'
  else
    let s:str='NORMAL '
    let s:color='18'
  endif
  exec 'highlight User3 ctermfg=7 ctermbg='.s:color
  exec 'highlight User4 ctermfg=7 ctermbg=16'
  redraw
  return s:str
endfunction
set laststatus=2
set statusline=%3*\ %{GetMode()}
set statusline+=%4*\ %F\ %m%r%h%w%=
set statusline+=%4*%Y｜
set statusline+=%4*%{\"\".(\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"\"}｜
set statusline+=%4*%l:%v:%-L%3p%%\ 

""" TABLINE """
let s:tab_after=""
function! TabLine(direct)
  let s:tab_result=""
  let flag=0
  if a:direct
    return s:tab_after!=""?s:tab_after."|":"\ "
  else
    let s:tab_after=""
  endif
  for buf in getbufinfo({'buflisted':1})
    let s:name=buf.name
    if strridx(buf.name,"/")!=-1
      let s:name=strpart(buf.name,strridx(buf.name,"/")+1)
    endif
    if buf.name!=expand('%:p')
      let bt=getbufvar(buf.bufnr,"&buftype")
      if bt!=""
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
endfunction
function! TabLineSet()
  if len(gettabinfo())>1
    return "%5* Tab %2*%=%1* buffer "
  endif
  if &modified
    let tab="%2* %0.32(%{TabLine(0)}%)%5*\ %t\ %6*%2*%<%{TabLine(1)}%r%h%w%=%6*\ %5* buffer "
  else
    let tab="%2* %0.32(%{TabLine(0)}%)%1*\ %t\ %2*%2*%<%{TabLine(1)}%r%h%w%=%2*\ %1* buffer "
  endif
  return tab
endfunction
set showtabline=2
set tabline=%!TabLineSet()

""" AUTO-PAIRS """
function! s:Judge(ch,mode)
  if a:mode!='c'
    let ch=getline('.')[col('.')-1]
  else
    let ch=getcmdline()[getcmdpos()-1]
  endif
  if a:ch=='"'||a:ch=="'"||a:ch=='`'
    if ch!=a:ch
      return a:ch.a:ch."\<left>"
    endif
  endif
  if ch==a:ch
    return "\<right>"
  endif
  return a:ch
endfunction
function! s:BackSpace(mode)
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
endfunction
let g:pair_map={ '(':')', '[':']', '{':'}', '"':'"', "'":"'", '<':'>', '`':'`' }
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
cnoremap ( ()<left>
cnoremap [ []<left>
cnoremap { {}<left>
inoremap <expr><silent>" <sid>Judge('"', 'i')
inoremap <expr><silent>` <sid>Judge('`', 'i')
inoremap <expr><silent>' <sid>Judge("'", 'i')
inoremap <expr><silent>> <sid>Judge('>', 'i')
inoremap <expr><silent>) <sid>Judge(')', 'i')
inoremap <expr><silent>} <sid>Judge('}', 'i')
inoremap <expr><silent>] <sid>Judge(']', 'i')
cnoremap <expr>" <sid>Judge('"', 'c')
cnoremap <expr>` <sid>Judge('`', 'c')
cnoremap <expr>' <sid>Judge("'", 'c')
cnoremap <expr>> <sid>Judge('>', 'c')
cnoremap <expr>) <sid>Judge(')', 'c')
cnoremap <expr>} <sid>Judge('}', 'c')
cnoremap <expr>] <sid>Judge(']', 'c')
inoremap <expr><bs> <sid>BackSpace('i')
cnoremap <expr><bs> <sid>BackSpace('c')

""" VIM-COMMENTARY """
func! s:Commentary(line) abort
  let s:num=a:line
  let line=getline(s:num)
  let uncomment=2
  let [l, r] = split(substitute(substitute(substitute(&commentstring, '^$', '%s', ''), '\S\zs%s', ' %s', ''), '%s\ze\S', '%s ', ''), '%s', 1)
  let line=matchstr(getline(s:num), '\S.*\s\@<!')
  if l[-1:]==#' '&&stridx(line, l)==-1&&stridx(line, l[0:-2])==0
    let l=l[:-2]
  endif
  if r[0]==#' '&&line[-strlen(r):]!=r&&line[1-strlen(r):]==r[1:]
    let r=r[1:]
  endif
  if len(line)&&(stridx(line, l)||line[strlen(line)-strlen(r):-1]!=r)
    let uncomment=0
  endif
  let line=getline(s:num)
  let [l, r] = split(substitute(substitute(substitute(&commentstring, '^$', '%s', ''), '\S\zs%s', ' %s', ''), '%s\ze\S', '%s ', ''), '%s', 1)
  if strlen(r)>2&&l.r!~#'\\'
    let line=substitute(line, '\M'.substitute(l, '\ze\S\s*$', '\\zs\\d\\*\\ze', '').'\|'.substitute(r, '\S\zs', '\\zs\\d\\*\\ze', ''), '\=substitute(submatch(0)+1-uncomment, "^0$\\|^-\\d*$", "", "")', 'g')
  endif
  if uncomment
    let line=substitute(line, '\S.*\s\@<!', '\=submatch(0)[strlen(l):-strlen(r)-1]', '')
  else
    let line=substitute(line, '^\%('.matchstr(getline(s:num), '^\s*').'\|\s*\)\zs.*\S\@<=', '\=l.submatch(0).r', '')
  endif
  call setline(s:num, line)
endfunc
func! s:VisualComment() abort
  for temp in range(min([line('.'), line('v')]), max([line('.'), line('v')]))
    call s:Commentary(temp)
  endfor
endfunc
nnoremap <silent><nowait>gcc :call <sid>Commentary(line('.'))<cr>
xnoremap <silent><nowait>gc :call <sid>VisualComment()<cr>
