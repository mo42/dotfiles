set nocompatible
filetype off
" Set up Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'takac/vim-hardtime'
Plugin 'pangloss/vim-javascript'
call vundle#end()
" Enable file type plugins
filetype plugin on
" No annoyances
set noerrorbells
set novisualbell
set vb t_vb=
" Show line numbers
set number
" Show relative line numbers
set relativenumber
" Highlight the current line
set cursorline
" Highlight the current column
set cursorcolumn
" Read the file again when changed outside
set autoread
" Use enhanced command completion
set wildmode=longest,full
set wildmenu
" Show word completion
set completeopt=longest,menuone,preview
" Show specific characters
set list
set listchars=tab:>-,trail:·
" Ignore some file types
set wildignore+=*.o,*.pdf
" Highlight search results
set hlsearch
" Search while typing
set incsearch
" If the search string contains uppercase letters do not ignore case
set ignorecase
set smartcase 
" Regular expression as usual
set magic
" Show matching brackets
set showmatch
" Time (s/10) to show matching bracket
set matchtime=2
set mat=2
" Enable syntax highlighting and colors
syntax enable
" Remove annoying buttons in GUI mode
if has("gui_gtk3")
  " Remove menu bar
  set guioptions-=m
  " Remove toolbar
  set guioptions-=T
  " Remove scroll bars
  set guioptions-=r
  set guioptions-=L
  set background=dark
  set guifont=DejaVu\ Sans\ Mono\ 12
  " Do not blink
  set guicursor+=a:blinkon0
else
  set background=dark
endif
color molokai
" Default encoding
set encoding=utf8
" Enable undoing and disable backup and swap files
set undofile
set undodir=$HOME/.vim/undodir/
set undoreload=10000
set undolevels=10000
set noswapfile
set nobackup
set nowritebackup
" Disable startup message
set shortmess=I
" Hide the mouse while typing
set mousehide
" Use two spaces instead of tabs
set expandtab
set shiftwidth=2
set tabstop=2
" Text should be no longer than ~80 characters
set textwidth=78 
" Automatically indent next line
set autoindent
" Move normally on long lines
map j gj
map k gk
" Allow unsaved buffers
set hidden
" Change mode quickly
inoremap jk <esc>
" Fast way to move between windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l
" New windows are below or right
set splitbelow
set splitright
" Move between buffers
nnoremap <silent> <c-l> :bn<cr>
nnoremap <silent> <c-h> :bp<cr>
" Save viminfo somewhere else
set viminfo+=n~/.vim/viminfo
" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
autocmd FocusLost * :ws
" Automatically convert to Unix line endings
autocmd BufWrite * :set ff=unix
" Visually wrap long lines
set wrap
" Number of line above and below the cursor
set scrolloff=5
" Define leader key
let mapleader=","
" Fast file saving
noremap <leader>w :w<cr>
" Look up help quickly (trailing space intended)
nnoremap <leader>h :help 
" Close window
noremap <leader>q :q<cr>
" Repeat last colon command
map <leader>. @:
" Show end of lines
set colorcolumn=80
" Always show status line
set laststatus=2
" Double newline (useful in various cases)
imap <c-j> <cr><cr>
" No need to leave the home row for backward delete
imap <c-d> <del>
" Insert date
iab <expr> DATE strftime("%Y-%m-%d")
iab <expr> FULLISODATE strftime("%Y-%m-%dT%H:%M:%S%z")
" Space scrolls down in normal mode
nmap <space> <pagedown>
nmap <c-space> <pageup>
" Regular vim format
map Q gqip
" Integrate clang-format
map <c-k> :pyf /usr/share/clang/clang-format.py<cr>
imap <c-k> <c-o>:pyf /usr/share/clang/clang-format.py<cr>
" Void annoying prompts
set shortmess=a
" Use make
map <c-m> :make<cr>
" Look for files in the entire subtree
set path+=**
" Enable spell checking
set spell
function! s:insert_guards()
  let guardname = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . guardname
  execute "normal! o#define " . guardname . " "
  execute "normal! Go#endif /* " . guardname . " */"
  normal! ko
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_guards()
" Make ctrl-f directly available
map <leader>f <esc>:<c-f>
let g:hardtime_default_on = 1
let g:hardtime_timeout = 8000
let g:hardtime_showmsg = 1
let g:hardtime_maxcount = 2
let g:hardtime_allow_different_key = 1
let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "x", "w", "b", "dd"]
" Plugin settings: vim-javascript
let g:javascript_plugin_jsdoc = 1
