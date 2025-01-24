"""""""""""""""""
""" REFERENCE """
"""""""""""""""""
" https://github.com/junegunn/vim-plug/wiki/tips
" https://github.com/skywind3000/vim-init
" https://github.com/wklken/k-vim
" https://github.com/amix/vimrc
" https://gitee.com/mirrorvim/vim-fast/blob/master/vimrc-no-plug
" https://github.com/chenxuan520/vim-fast

""""""""""""""
""" OPTION """
""""""""""""""
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
set nocursorcolumn
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
set pumheight=12
set pumwidth=20
let g:vim_indent_cont=&sw

""""""""""""""""""
""" KEYBINDING """
""""""""""""""""""
let mapleader='\'
let maplocalleader=' '
nnoremap <Leader>CE :edit $MYVIMRC<CR>
nnoremap <Leader>CR :source $MYVIMRC<CR>
inoremap jk <ESC>
vnoremap jk <ESC>
cnoremap jk <C-c>

""""""""""""""""""""""
""" BUILTIN PLUGIN """
""""""""""""""""""""""
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

"""""""""""""""
""" AUTOCMD """
"""""""""""""""
autocmd BufReadPost * if line("'\"")>1 && line("'\"")<=line('$')
  \| exe "normal! g'\""
  \| endif
autocmd BufWinEnter * if getfsize(expand('%'))>1048576
  \| syntax clear
  \| endif
autocmd BufEnter * setlocal formatoptions-=r formatoptions-=c formatoptions-=o
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType help noremap <buffer>q :bd<CR>
autocmd FileType c,cpp setlocal commentstring=//\ %s

""""""""""""""""""""""""
""" INSTALL VIM-PLUG """
""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd BufWinEnter * PlugInstall --sync
    \| source $MYVIMRC
endif
autocmd BufWinEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))>0
  \| PlugInstall --sync
  \| source $MYVIMRC
  \| endif

"""""""""""""""""""""""
""" INSTALL PLUGINS """
"""""""""""""""""""""""
call plug#begin()
Plug 'vim-airline/vim-airline', { 'on': [] }
Plug 'LunarWatcher/auto-pairs', { 'on': [] }
Plug 'tpope/vim-commentary', { 'on': [] }
Plug 'dense-analysis/ale', { 'on': [] }
Plug 'ap/vim-css-color', { 'on': [] }
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'junegunn/fzf', { 'do': { ->fzf#install() } }
Plug 'junegunn/fzf.vim', { 'on': ['Files', 'Buffers', 'Colors', 'Lines', 'BLines', 'History', 'Commands', 'Rg'] }
Plug 'prabirshrestha/asyncomplete.vim', { 'on': [] }
Plug 'prabirshrestha/asyncomplete-buffer.vim', { 'on': [] }
Plug 'prabirshrestha/asyncomplete-file.vim', { 'on': [] }
Plug 'prabirshrestha/asyncomplete-lsp.vim', { 'on': [] }
Plug 'prabirshrestha/vim-lsp', { 'on': [] }
Plug 'mattn/vim-lsp-settings', { 'on': ['LspInstallServer', 'LspManageServers'] }
Plug 'hrsh7th/vim-vsnip', { 'on': [] }
Plug 'hrsh7th/vim-vsnip-integ', { 'on': [] }
call plug#end()

" VIM-AIRLINE
augroup LOAD_VIM_AIRLINE
  autocmd!
  autocmd BufReadPost * call plug#load('vim-airline')
    \| autocmd! LOAD_VIM_AIRLINE
    \| let g:airline_extensions=['branch', 'tabline', 'ale']
augroup END

" AUTO-PAIRS
augroup LOAD_AUTO_PAIRS
  autocmd!
  autocmd InsertEnter * call plug#load('auto-pairs')
    \| autocmd! LOAD_AUTO_PAIRS
    \| call autopairs#AutoPairsTryInit()
augroup end

" VIM-COMMENTARY
augroup LOAD_VIM_COMMENTARY
  autocmd!
  autocmd BufReadPost * call plug#load('vim-commentary')
    \| autocmd! LOAD_VIM_COMMENTARY
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
augroup END

" VIM-WHICH-KEY
nnoremap <silent><Leader> :<C-u>WhichKey '\'<CR>
nnoremap <silent><LocalLeader> :<C-u>WhichKey '<Space>'<CR>

" FZF & FZF.VIM
let g:fzf_layout={ 'down': '30%' }
nnoremap <Leader>ff <Cmd>Files<CR>
nnoremap <Leader>fF <Cmd>Files ~/<CR>
nnoremap <Leader>fb <Cmd>Buffers<CR>
nnoremap <Leader>fw <Cmd>Rg<CR>
nnoremap <Leader>fs <Cmd>BLines<CR>
nnoremap <Leader>fr <Cmd>History<CR>
nnoremap <Leader>fc <Cmd>Colors<CR>
nnoremap <Leader><Leader> <Cmd>Commands<CR>

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
    \| call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'blocklist': ['go'], 
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': { 'max_buffer_size': 100000 }
    \ }))
    \| call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
    \| call lsp#enable()
    \| if executable('clangd') 
    \| call lsp#register_server({
    \ 'name': 'clangd',
    \ 'cmd': { server_info -> ['clangd', '--background-index', '--clang-tidy'] },
    \ 'whitelist': ['c', 'cpp']
    \ }) 
    \| endif
    \| if executable('pylsp') 
    \| call lsp#register_server({
    \ 'name': 'pylsp',
    \ 'cmd': { server_info -> ['pylsp'] },
    \ 'whitelist': ['python']
    \ }) 
    \| endif
augroup END
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc')|setlocal tagfunc=lsp#tagfunc|endif
  nmap <Buffer> gd <Plug>(lsp-definition)
  nmap <Buffer> gs <Plug>(lsp-document-symbol-search)
  nmap <Buffer> gr <Plug>(lsp-references)
  nmap <Buffer> gi <Plug>(lsp-implementation)
  nmap <Buffer> K <plug>(lsp-hover)
  nnoremap <Buffer> <EXPR><C-f> lsp#scroll(+4)
  nnoremap <Buffer> <EXPR><C-b> lsp#scroll(-4)
  let g:lsp_format_sync_timeout=1000
  autocmd! bufwritepre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction
augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
