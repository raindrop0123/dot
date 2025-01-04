"""""""""""""
" REFERENCE "
"""""""""""""
" https://github.com/junegunn/vim-plug/wiki/tips
" https://github.com/skywind3000/vim-init
" https://github.com/wklken/k-vim
" https://github.com/amix/vimrc
" https://gitee.com/mirrorvim/vim-fast/blob/master/vimrc-no-plug
" https://github.com/chenxuan520/vim-fast

""""""""""
" OPTION "
""""""""""
filetype on
filetype plugin on
filetype indent on
syntax enable
syntax on
set autoread
set backspace=indent,eol,start
set ruler
set number
set relativenumber
set cursorline
set cursorcolumn
set colorcolumn=80
set splitbelow
set splitright
set clipboard^=unnamed,unnamedplus
set nowrap
set showtabline=2
set laststatus=2
set wildmenu
set autoindent
set cindent
set smartindent
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
set notermguicolors
set background=dark
set timeoutlen=200
let g:vim_indent_cont=&sw

""""""""""""""
" KEYBINDING "
""""""""""""""
let mapleader='\'
let maplocalleader=' '
nnoremap <Leader>CE :edit $MYVIMRC<CR>
nnoremap <Leader>CR :source $MYVIMRC<CR>
inoremap jk <ESC>
vnoremap jk <ESC>
cnoremap jk <C-c>

""""""""""""""""""
" BUILTIN PLUGIN "
""""""""""""""""""
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

"""""""""""
" AUTOCMD "
"""""""""""
autocmd BufReadPost * if line("'\"")>1 && line("'\"")<=line('$') | exe "normal! g'\"" | endif
autocmd BufEnter * setlocal formatoptions-=r formatoptions-=c formatoptions-=o
autocmd BufWinEnter * if getfsize(expand('%'))>1048576 | syntax clear | endif
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType help noremap <buffer>q :bd<CR>

""""""""""""""""""""
" INSTALL VIM-PLUG "
""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd BufWinEnter * PlugInstall --sync | source $MYVIMRC
endif
autocmd BufWinEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))>0 | PlugInstall --sync | source $MYVIMRC | endif

"""""""""""""""""""
" INSTALL PLUGINS "
"""""""""""""""""""
call plug#begin()

""""""
" UI "
""""""
Plug 'sheerun/vim-polyglot', { 'on': [] }
Plug 'morhetz/gruvbox', { 'on': [] }
Plug 'ryanoasis/vim-devicons', { 'on': [] }
Plug 'vim-airline/vim-airline', { 'on': [] }
Plug 'Yggdroot/indentLine', { 'on': [] }
Plug 'ntpeters/vim-better-whitespace', { 'on': [] }
Plug 'machakann/vim-highlightedyank', { 'on': [] }
Plug 'wincent/terminus', { 'on': [] }

""""""""""
" EDITOR "
""""""""""
Plug 'LunarWatcher/auto-pairs', { 'on': [] }
Plug 'luochen1990/rainbow', { 'on': [] }
Plug 'tpope/vim-commentary', { 'on': [] }
Plug 'wellle/context.vim', { 'on': [] }
Plug 'andymass/vim-matchup', { 'on': [] }
Plug 'airblade/vim-gitgutter', { 'on': [] }
Plug 'dense-analysis/ale', { 'on': [] }
Plug 'ap/vim-css-color', { 'on': [] }
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

""""""""
" TOOL "
""""""""
Plug 'easymotion/vim-easymotion', { 'on': ['<Plug>(easymotion-overwin-line)', '<Plug>(easymotion-overwin-w)', '<Plug>(easymotion-bd-jk)', '<Plug>(easymotion-bd-w)'] }
Plug 'mbbill/undotree', { 'on': ['UndotreeToggle'] }
Plug 'thinca/vim-quickrun', { 'on': ['QuickRun'] }
Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle'] }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeToggle'] }
Plug 'junegunn/fzf', { 'do': { ->fzf#install() } }
Plug 'junegunn/fzf.vim', { 'on': ['Files', 'Buffers', 'Colors', 'Lines', 'BLines', 'History', 'Commands'] }
Plug 'junegunn/limelight.vim', { 'on': ['Limelight'] }
Plug 'junegunn/goyo.vim', { 'on': ['Goyo'] }
Plug 'dyng/ctrlsf.vim', { 'on': ['CtrlSF'] }
Plug 'lambdalisue/vim-suda', { 'on': ['SudaRead', 'SudaWrite'] }

""""""""""""""""""""""""
" COMPLETION & SNIPPET "
""""""""""""""""""""""""
Plug 'prabirshrestha/asyncomplete.vim', { 'on': [] }
Plug 'prabirshrestha/asyncomplete-buffer.vim', { 'on': [] }
Plug 'prabirshrestha/asyncomplete-file.vim', { 'on': [] }
Plug 'prabirshrestha/asyncomplete-lsp.vim', { 'on': [] }
Plug 'prabirshrestha/vim-lsp', { 'on': [] }
Plug 'mattn/vim-lsp-settings', { 'on': ['LspInstallServer', 'LspManageServers'] }
Plug 'hrsh7th/vim-vsnip', { 'on': [] }
Plug 'hrsh7th/vim-vsnip-integ', { 'on': [] }

call plug#end()

""""""
" UI "
""""""
" VIM-POLYGLOT
augroup LOAD_VIM_POLYGLOT
  autocmd!
  autocmd InsertEnter * call plug#load('vim-polyglot')
    \| autocmd! LOAD_VIM_POLYGLOT
augroup END

" GRUVBOX
augroup LOAD_GRUVBOX
  autocmd!
  autocmd BufReadPost * call plug#load('gruvbox')
    \| autocmd! LOAD_GRUVBOX
    \| colorscheme gruvbox
augroup END

" VIM-DEVICONS
augroup LOAD_VIM_DEVICONS
  autocmd!
  autocmd BufReadPost * call plug#load('vim-devicons')
    \| autocmd! LOAD_VIM_DEVICONS
augroup END

" VIM-AIRLINE
augroup LOAD_VIM_AIRLINE
  autocmd!
  autocmd BufReadPost * call plug#load('vim-airline')
    \| autocmd! LOAD_VIM_AIRLINE
    \| let g:airline_extensions=['branch', 'tabline', 'ale']
augroup END

" INDENTLINE
augroup LOAD_INDENTLINE
  autocmd!
  autocmd BufReadPost * call plug#load('indentLine')
    \| autocmd! LOAD_INDENTLINE
    \| let g:indentLine_char_list=['│']
    \| IndentLinesEnable
augroup END

" VIM-BETTER-WHITESPACE
augroup LOAD_VIM_BETTER_WHITESPACE
  autocmd!
  autocmd BufReadPost * call plug#load('vim-better-whitespace')
    \| autocmd! LOAD_VIM_BETTER_WHITESPACE
augroup END

" VIM-HIGHLIGHTEDYANK
augroup LOAD_VIM_HIGHLIGHTEDYANK
  autocmd!
  autocmd BufReadPost * call plug#load('vim-highlightedyank')
    \| autocmd! LOAD_VIM_HIGHLIGHTEDYANK
    \| let g:highlightedyank_highlight_duration=2500
augroup END

" TERMINUS
augroup LOAD_TERMINUS
  autocmd!
  autocmd InsertEnter * call plug#load('terminus')
    \| autocmd! LOAD_TERMINUS
augroup END

""""""""""
" EDITOR "
""""""""""
" AUTO-PAIRS
augroup LOAD_AUTO_PAIRS
  autocmd!
  autocmd InsertEnter * call plug#load('auto-pairs')
    \| autocmd! LOAD_AUTO_PAIRS
    \| call autopairs#AutoPairsTryInit()
augroup end

" RAINBOW
augroup LOAD_RAINBOW
  autocmd!
  autocmd InsertEnter * call plug#load('rainbow')
    \| autocmd! LOAD_RAINBOW
    \| let g:rainbow_active=1
    \| call rainbow_main#toggle()
augroup END

" VIM-COMMENTARY
augroup LOAD_VIM_COMMENTARY
  autocmd!
  autocmd BufReadPost * call plug#load('vim-commentary')
    \| autocmd! LOAD_VIM_COMMENTARY
augroup END

" CONTEXT.VIM
augroup LOAD_CONTEXT_VIM
  autocmd!
  autocmd BufReadPost * call plug#load('context.vim')
    \| autocmd! LOAD_CONTEXT_VIM
    \| let g:context_max_height=1
augroup END

" VIM-MATCHUP
augroup LOAD_VIM_MATCHUP
  autocmd!
  autocmd BufReadPost * call plug#load('vim-matchup')
    \| autocmd! LOAD_VIM_MATCHUP
augroup END

" VIM-GITGUTTER
augroup LOAD_VIM_GITGUTTER
  autocmd!
  autocmd BufReadPost * call plug#load('vim-gitgutter')
    \| autocmd! LOAD_VIM_GITGUTTER
    \| call gitgutter#enable()
augroup END

" ALE
augroup LOAD_ALE
  autocmd!
  autocmd BufReadPost * call plug#load('ale')
    \| autocmd! LOAD_ALE
augroup END

" VIM-CSS-COLOR
augroup LOAD_VIM_CSS_COLOR
  autocmd!
  autocmd BufReadPre * call plug#load('vim-css-color')
    \| autocmd! LOAD_VIM_CSS_COLOR
augroup end

" VIM-WHICH-KEY
nnoremap <silent><Leader> :<C-u>WhichKey '\'<CR>
nnoremap <silent><LocalLeader> :<C-u>WhichKey '<Space>'<CR>

""""""""
" TOOL "
""""""""
" VIM-EASYMOTION
let g:EasyMotion_do_mapping=0
nmap <Leader>gl <Plug>(easymotion-bd-jk)
nmap <Leader>gw <Plug>(easymotion-bd-w)

" UNDOTREE
nnoremap <Leader>tu <Cmd>UndotreeToggle<CR>

" QUICKRUN
nnoremap <Leader>RR <Cmd>QuickRun<CR>

" NERDTREE & NERDTREE-GIT-PLUGIN
let g:NERDTreeWinSize=20
let g:NERDTreeShowHidden=1
nnoremap <F1> <Cmd>NERDTreeToggle<CR>

" FZF & FZF.VIM
let g:fzf_layout={ 'down': '30%' }
nnoremap <C-x><C-f> <Cmd>Files<CR>
nnoremap <C-x><C-b> <Cmd>Buffers<CR>
nnoremap <C-x><C-w> <Cmd>Rg<CR>
nnoremap <C-s> <Cmd>BLines<CR>
nnoremap <C-x><C-r> <Cmd>History<CR>
nnoremap <Leader><Leader> <Cmd>Commands<CR>

"""""""""""""""""""""""""
" COMPLETIOIN & SNIPPET "
"""""""""""""""""""""""""
" ASYNCOMPLETE.VIM
" ASYNCOMPLETE-BUFFER.VIM
" ASYNCOMPLETE-FILE.VIM
" ASYNCOMPLETE-LSP.VIM
" VIM-LSP
" VIM-VSNIP
" VIM-VSNIP-INTEG
imap <expr><Tab> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : pumvisible() ? "\<C-n>" : "\<Tab>"
smap <expr><Tab> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr><S-Tab> vsnip#available(1) ? '<Plug>(vsnip-jump-prev)' : pumvisible() ? "\<C-p>" : "\<S-Tab>"
smap <expr><S-Tab> vsnip#available(1) ? '<Plug>(vsnip-jump-prev)' : pumvisible() ? "\<C-p>" : "\<S-Tab>"
augroup LOAD_ASYNCOMPLETE_AND_SNIPPET
  autocmd!
  autocmd InsertEnter * call plug#load('asyncomplete.vim', 'asyncomplete-buffer.vim',
    \ 'asyncomplete-file.vim', 'asyncomplete-lsp.vim', 'vim-lsp', 'vim-vsnip',
    \ 'vim-vsnip-integ')
    \| autocmd! LOAD_ASYNCOMPLETE_AND_SNIPPET
    \| let g:lsp_diagnostics_enabled=0
    \| call asyncomplete#enable_for_buffer()
    \| call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({ 'name': 'buffer', 'allowlist': ['*'], 'blocklist': ['go'], 'completor': function('asyncomplete#sources#buffer#completor'), 'config': { 'max_buffer_size': 100000 } }))
    \| call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({ 'name': 'file', 'allowlist': ['*'], 'priority': 10, 'completor': function('asyncomplete#sources#file#completor') }))
    \| call lsp#enable()
    \| if executable('clangd') | call lsp#register_server({ 'name': 'clangd', 'cmd': { server_info -> ['clangd', '--background-index', '--clang-tidy'] }, 'whitelist': ['c', 'cpp'] }) | endif
    \| if executable('pylsp') | call lsp#register_server({ 'name': 'pylsp', 'cmd': { server_info -> ['pylsp'] }, 'whitelist': ['python'] }) | endif
augroup end
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc')|setlocal tagfunc=lsp#tagfunc|endif
  nmap <buffer> gd <Plug>(lsp-definition)
  nmap <buffer> gs <Plug>(lsp-document-symbol-search)
  nmap <buffer> gr <Plug>(lsp-references)
  nmap <buffer> gi <Plug>(lsp-implementation)
  nmap <buffer> K <plug>(lsp-hover)
  nnoremap <buffer> <expr><C-f> lsp#scroll(+4)
  nnoremap <buffer> <expr><C-b> lsp#scroll(-4)
  let g:lsp_format_sync_timeout=1000
  autocmd! bufwritepre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction
augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup end
