""" REFERENCE """
" https://github.com/junegunn/vim-plug/wiki/tips
" https://github.com/skywind3000/vim-init
" https://github.com/wklken/k-vim
" https://github.com/amix/vimrc

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
colorscheme habamax

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

""" GUI SETUP """
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

""" DISTRIBUTION PLUGINS """
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

""" VIM-PLUGIN """
let data_dir=has('nvim')?stdpath('data').'/site':'~/.vim'
if empty(glob(data_dir.'/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))>0 | PlugInstall --sync | source $MYVIMRC | endif

call plug#begin()
Plug 'sheerun/vim-polyglot', { 'on': [] }
Plug 'morhetz/gruvbox', { 'on': [] }
Plug 'vim-airline/vim-airline', { 'on': [] }
Plug 'ryanoasis/vim-devicons', { 'on': [] }
Plug 'Yggdroot/indentLine', { 'on': [] }
Plug 'airblade/vim-gitgutter', { 'on': [] }
Plug 'tpope/vim-commentary', { 'on': [] }
Plug 'ntpeters/vim-better-whitespace', { 'on': [] }
Plug 'andymass/vim-matchup', { 'on': [] }
Plug 'LunarWatcher/auto-pairs', { 'on': [] }
Plug 'luochen1990/rainbow', { 'on': [] }
Plug 'machakann/vim-highlightedyank', { 'on': [] }
Plug 'wellle/context.vim', { 'on': [] }
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle'] }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', { 'on': ['Files', 'Buffers', 'Colors', 'Rg', 'Lines', 'BLines', 'History', 'Commands'] }
Plug 'dyng/ctrlsf.vim', { 'on': ['CtrlSF'] }
Plug 'thinca/vim-quickrun', { 'on': ['QuickRun'] }
Plug 'easymotion/vim-easymotion', { 'on': ['<Plug>(easymotion-bd-jk)', '<Plug>(easymotion-bd-w)'] }
Plug 'voldikss/vim-floaterm', { 'on': ['FloatermNew', 'FloatermToggle'] }
Plug 'dense-analysis/ale', { 'on': [] }
Plug 'prabirshrestha/asyncomplete.vim', { 'on': [] }
Plug 'prabirshrestha/asyncomplete-buffer.vim', { 'on': [] }
Plug 'prabirshrestha/asyncomplete-file.vim', { 'on': [] }
Plug 'prabirshrestha/asyncomplete-lsp.vim', { 'on': [] }
Plug 'prabirshrestha/vim-lsp', { 'on': [] }
Plug 'mattn/vim-lsp-settings', { 'on': ['LspInstallServer', 'LspManageServers'] }
call plug#end()

" vim-polyglot
augroup plug_vim_polyglot
  autocmd!
  autocmd InsertEnter * call plug#load('vim-polyglot')
        \| autocmd! plug_vim_polyglot
augroup END

" gruvbox
augroup plug_gruvbox
  autocmd!
  autocmd BufEnter,BufReadPost * call plug#load('gruvbox')
        \| autocmd! plug_gruvbox
        \| colorscheme gruvbox
augroup END

" vim-airline
augroup plug_vim_airline
  autocmd!
  autocmd BufReadPost * call plug#load('vim-airline')
        \| autocmd! plug_vim_airline
        \| let g:airline#extensions#tabline#enabled=1
augroup END

" vim-devicons
augroup plug_vim_devicons
  autocmd!
  autocmd BufReadPost * call plug#load('vim-devicons')
        \| autocmd! plug_vim_devicons
augroup END

" indentLine
augroup plug_indentline
  autocmd!
  autocmd BufReadPost * call plug#load('indentLine')
        \| autocmd! plug_indentline
        \| let g:indentLine_char_list=['│']
        \| IndentLinesToggle
augroup END

" vim-gitgutter
augroup plug_vim_gitgutter
  autocmd!
  autocmd BufReadPost * call plug#load('vim-gitgutter')
        \| autocmd! plug_vim_gitgutter
        \| call gitgutter#enable()
augroup END

" vim-commentary
augroup plug_vim_commentary
  autocmd!
  autocmd BufReadPost * call plug#load('vim-commentary')
        \| autocmd! plug_vim_commentary
augroup END

" vim-better-whitespace
augroup plugin_vim_better_whitespace
  autocmd!
  autocmd BufReadPost * call plug#load('vim-better-whitespace')
        \| autocmd! plugin_vim_better_whitespace
        \| ToggleWhitespace
augroup END

" vim-matchup
augroup plug_vim_matchup
  autocmd!
  autocmd BufReadPost * call plug#load('vim-matchup')
        \| autocmd! plug_vim_matchup
        \| call matchup#init()
augroup END

" auto-pairs
augroup plug_auto_pairs
  autocmd!
  autocmd InsertEnter * call plug#load('auto-pairs')
        \| autocmd! plug_auto_pairs
        \| call autopairs#AutoPairsTryInit()
augroup END

" rainbow
augroup plug_rainbow
  autocmd!
  autocmd InsertEnter * call plug#load('rainbow')
        \| autocmd! plug_rainbow
        \| call rainbow_main#toggle()
augroup END

" vim-highlightedyank
augroup plug_vim_highlightedyank
  autocmd!
  autocmd BufReadPost * call plug#load('vim-highlightedyank')
        \| autocmd! plug_vim_highlightedyank
        \| let g:highlightedyank_highlight_duration=2000
augroup END

" context.vim
augroup plug_context_vim
  autocmd!
  autocmd BufReadPost * call plug#load('context.vim')
        \| autocmd! plug_context_vim
        \| ContextEnable
augroup END

" which-key
nnoremap <Leader> :<c-u>WhichKey '\'<cr>
nnoremap <localleader> :<c-u>WhichKey '<Space>'<cr>

" nerdtree
let g:NERDTreeWinSize=20
let g:NERDTreeShowHidden=1
nnoremap <c-n> <cmd>NERDTreeToggle<cr>

" fzf.vim
nnoremap <leader>ff <cmd>Files<cr>
nnoremap <leader>fF <cmd>Files ~/<cr>
nnoremap <leader>fb <cmd>Buffers<cr>
nnoremap <leader>fc <cmd>Colors<cr>
nnoremap <leader>fw <cmd>Rg<cr>
nnoremap <leader>fs <cmd>BLines<cr>
nnoremap <leader>fS <cmd>Lines<cr>
nnoremap <leader>fr <cmd>History<cr>
nnoremap <leader><leader> <cmd>Commands<cr>
nnoremap <localleader><localleader> <cmd>Commands<cr>

" quickrun
nnoremap <leader>rf <cmd>QuickRun<cr>

" vim-easymotion
let g:EasyMotion_do_mapping=0
nnoremap <leader>gl <Plug>(easymotion-bd-jk)
nnoremap <leader>gw <Plug>(easymotion-bd-w)

" vim-floaterm
nnoremap <leader>tt <cmd>FloatermToggle<cr>
tnoremap <leader>tt <c-\><c-n><cmd>FloatermToggle<cr>

" ale
augroup plug_ale
  autocmd!
  autocmd InsertEnter * call plug#load('ale')
        \| autocmd! plug_ale
augroup END

" asyncomplete.vim
" asyncomplete-buffer.vim
" asyncomplete-file.vim
" asyncomplete-lsp.vim
" vim-lsp
" vim-lsp-settings
inoremap <expr> <Tab> pumvisible()?"\<C-n>":"\<Tab>"
inoremap <expr> <S-Tab> pumvisible()?"\<C-p>":"\<S-Tab>"
inoremap <expr> <cr> pumvisible()?asyncomplete#close_popup():"\<cr>"
augroup plug_asyncomplete_vim
  autocmd!
  autocmd InsertEnter * call plug#load('asyncomplete.vim', 'asyncomplete-buffer.vim', 'asyncomplete-file.vim', 'asyncomplete-lsp.vim', 'vim-lsp')
        \| autocmd! plug_asyncomplete_vim
        \| call asyncomplete#enable_for_buffer()
        \| call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({ 'name': 'buffer', 'allowlist': ['*'], 'blocklist': ['go'], 'completor': function('asyncomplete#sources#buffer#completor'), 'config': { 'max_buffer_size': 100000 } }))
        \| call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({ 'name': 'file', 'allowlist': ['*'], 'priority': 10, 'completor': function('asyncomplete#sources#file#completor') }))
        \| call lsp#enable()
        \| if executable('clangd') | call lsp#register_server({ 'name': 'clangd', 'cmd': { server_info->['clangd', '--background-index', '--clang-tidy'] }, 'whitelist': ['c', 'cpp'] }) | endif
        \| if executable('pylsp') | call lsp#register_server({ 'name': 'pylsp', 'cmd': { server_info->['pylsp'] }, 'whitelist': ['python'] }) | endif
augroup END
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc')
    setlocal tagfunc=lsp#tagfunc
  endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gs <plug>(lsp-document-symbol-search)
  nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
  nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
  nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
  let g:lsp_format_sync_timeout = 1000
  autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction
augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
