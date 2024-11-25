""" REFERENCE """
" https://github.com/junegunn/vim-plug/wiki/tips
" https://github.com/skywind3000/vim-init
" https://github.com/wklken/k-vim
" https://github.com/amix/vimrc
" https://gitee.com/mirrorvim/vim-fast/blob/master/vimrc-no-plug
" https://github.com/chenxuan520/vim-fast

""" OPTIONS """
let mapleader='\'
let maplocalleader=' '
filetype on
filetype plugin on
syntax enable
syntax on
set ruler
set showtabline=2
set laststatus=2
set number
set relativenumber
set cursorline
set cursorcolumn
set colorcolumn=80
set whichwrap+=<,>,h,l
set matchpairs+=<:>
set splitbelow
set splitright
set clipboard^=unnamed,unnamedplus
set nowrap
set backspace=2
set nofoldenable
set complete=.,b,i,w,u,t
set completeopt=menuone,noinsert,noselect,preview
set wildmenu
set notermguicolors
set background=dark
colorscheme habamax
set autoindent
set cindent
set smartindent
filetype indent on
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set hlsearch
set incsearch
set ignorecase
set smartcase
set nobackup
set noswapfile
set autoread
set autowrite
set confirm
set langmenu=en_US.UTF-8
set helplang=en
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

""" GUI """
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

""" DISTRIBUTED PLUGINS """
let g:loaded_getscriptPlugin=1
let g:loaded_gzip=1
let g:loaded_logiPat=1
let g:loaded_manpager=1
let g:loaded_matchit=1
let g:loaded_matchparen=1
let g:loaded_netrwPlugin=1
let g:loaded_rrhelper=1
let g:loaded_spellfile=1
let g:loaded_tarPlugin=1
let g:loaded_tohtml=1
let g:loaded_vimballPlugin=1
let g:loaded_zipPlugin=1

""" AUTOCMD """
autocmd BufReadPost * if line("'\"")>1&&line("'\"")<=line('$')|exe "normal! g'\""|endif
autocmd InsertEnter * setlocal formatoptions-=r formatoptions-=c formatoptions-=o
autocmd BufWinEnter * if getfsize(expand('%'))>1048576|syntax clear|endif

""" KEYBINDING """
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

""" VIM_PLUGIN """
let data_dir=has('nvim')?stdpath('data').'/site':'~/.vim'
if empty(glob(data_dir.'/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync|source $MYVIMRC
endif
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))>0|PlugInstall --sync|source $MYVIMRC|endif

call plug#begin()
Plug 'LunarWatcher/auto-pairs', {'on': []}
call plug#end()

augroup plug_auto_pairs
  autocmd!
  autocmd InsertEnter * call plug#load('auto-pairs')
        \| autocmd! plug_auto_pairs
        \| call autopairs#AutoPairsTryInit()
augroup END
