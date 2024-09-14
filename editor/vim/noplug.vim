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

" Change TAB
noremap <Leader>1 1gt
noremap <Leader>2 2gt
noremap <Leader>3 3gt
noremap <Leader>4 4gt
noremap <Leader>5 5gt
noremap <Leader>6 6gt
noremap <Leader>7 7gt
noremap <Leader>8 8gt
noremap <Leader>9 9gt
noremap <Leader>0 <CMD>tablast<CR>

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

" Change window width
nnoremap <C-up> <C-w>+
nnoremap <C-down> <C-w>-
nnoremap <C-left> <C-w><
nnoremap <C-right> <C-w>>

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

" vim-commentary
function! s:Commentary(line) abort
  let s:num=a:line
  let line=getline(s:num)
  let uncomment=2
  let [l, r]=split(substitute(substitute(substitute(&commentstring, '^$', '%s', ''), '\S\zs%s',' %s', '') ,'%s\ze\S', '%s ', ''), '%s', 1)
  let line=matchstr(getline(s:num), '\S.*\s\@<!')
  if (l[-1:]==#' ')&&(stridx(line,l)==-1)&&(stridx(line, l[0:-2])==0)
    let l=l[:-2]
  endif
  if (r[0]==#' ')&&(line[-strlen(r):]!=r)&&(line[1-strlen(r):]==r[1:])
    let r=r[1:]
  endif
  if (len(line))&&(stridx(line, l)||line[strlen(line)-strlen(r):-1]!=r)
    let uncomment = 0
  endif
  let line=getline(s:num)
  let [l, r]=split(substitute(substitute(substitute(&commentstring, '^$', '%s', ''), '\S\zs%s',' %s', '') ,'%s\ze\S', '%s ', ''), '%s', 1)
  if (strlen(r)>2)&&(l.r!~#'\\')
    let line=substitute(line, '\M'.substitute(l, '\ze\S\s*$', '\\zs\\d\\*\\ze', '').'\|'.substitute(r, '\S\zs', '\\zs\\d\\*\\ze', ''), '\=substitute(submatch(0)+1-uncomment, "^0$\\|^-\\d*$", "", "")', 'g')
  endif
  if uncomment
    let line=substitute(line, '\S.*\s\@<!', '\=submatch(0)[strlen(l):-strlen(r)-1]', '')
  else
    let line=substitute(line, '^\%('.matchstr(getline(s:num), '^\s*').'\|\s*\)\zs.*\S\@<=', '\=l.submatch(0).r', '')
  endif
  call setline(s:num,line)
endfunc
function! s:VisualComment() abort
  for temp in range(min([line('.'), line('v')]), max([line('.'), line('v')]))
    call s:Commentary(temp)
  endfor
endfunc
nnoremap <SILENT><NOWAIT>gcc :call <SID>Commentary(line('.'))<CR>
xnoremap <SILENT><NOWAIT>gc :call <SID>VisualComment()<CR>

" easymotion
let s:easymotion_key=['j', 'l', 'k', 'h', 'a', 's', 'd', 'f', 'g', 'q', 'w', 'e', 'r', 'u', 'i', 'o', 'p', 'c', 'v', 'b', 'n', 'm', 't', 'y', 'z', 'x']
let s:easymotion_leader=[';', ',', ' ', "'", '.', '/', '[', '\', ']']
let s:easymotion_leader_dict={';': 0, ',': 0, '.': 0, "'": 0, ' ': 0, '/': 0, '[': 0, '\': 0, ']': 0}
function! s:EasyMotion() abort
  echo 'Input:'
  let ch=nr2char(getchar())
  let s:easymotion={}
  let llen=len(s:easymotion_leader)+1
  let ch=tolower(ch)
  if (ch>='a')&&(ch<='z')
    let up=toupper(ch)
  else
    let up=''
  endif
  let info=winsaveview()
  let info['endline']=winheight(0)+info['topline']
  let width=winwidth(0)
  let num=0
  let old=ch
  let pos=0
  let klen=len(s:easymotion_key)
  if ch=='\<c-[>'
    return
  endif
  if &fen
    setlocal nofen
  endif
  let lines=getbufline('%', info['topline'], info['endline'])
  let bak=copy(lines)
  set nohlsearch
  let hlcomment=[]
  let begin=info['topline']
  let end=info['endline']
  while end-begin>=8
    call add(hlcomment, matchaddpos('comment', range(begin, end)))
    let begin+=8
  endwhile
  call add(hlcomment, matchaddpos('comment', range(begin, end)))
  let listl=range(0, len(lines)-1)
  let nowline=info['lnum']-info['topline']
  call sort(listl, {arg1, arg2 -> abs(arg2-nowline)-abs(arg1-nowline)})
  for i in listl
    " if i+info["topline"]==info["lnum"]|continue|endif
    while 1
      let pos=stridx(lines[i], ch, pos)
      if up!=""
        let postemp=stridx(lines[i], up, pos)
        if (postemp!=-1)&&(postemp<pos||pos==-1)
          let pos=postemp
        endif
      endif
      if (pos!=-1)&&(pos<width||&wrap)
        if num<klen
          let req=s:easymotion_key[num]
        elseif num<llen*klen
          let req=s:easymotion_leader[num/klen-1].s:easymotion_key[num%klen]
        else
          break
        endif
        let m=matchaddpos('incsearch', [[i+info['topline'], pos+1, len(req)]])
        let s:easymotion[req]={'line': i, 'pos': pos, 'hl': m}
        let lines[i]=strpart(lines[i], 0, pos).req.strpart(lines[i], pos+len(req))
        let num+=1
        let pos+=2
        if num>=llen*klen
          break
        endif
      else
        let pos=0
        break
      endif
    endwhile
    if num>=llen*klen
      break
    endif
  endfor
  if len(s:easymotion)==0
    echo 'Can not find'
  endif
  silent! undojoin
  call setline(info['topline'], lines)
  redraw!
  echo 'Key:'
  let ch=nr2char(getchar())
  if has_key(s:easymotion_leader_dict, ch)
    let ch=ch.nr2char(getchar())
  endif
  if has_key(s:easymotion, ch)
    let temp=s:easymotion[ch]
    call cursor(temp['line']+info['topline'], temp['pos']+1)
  endif
  for [key, val] in items(s:easymotion)
    let i=val['line']
    let pos=val['pos']
    let hl=val['hl']
    call matchdelete(hl)
  endfor
  for hlnow in hlcomment
    call matchdelete(hlnow)
  endfor
  silent! undojoin
  call setline(info['topline'], bak)
  setlocal nomodified
endfunc
nnoremap <leader>gw <CMD>call <SID>EasyMotion()<CR>
