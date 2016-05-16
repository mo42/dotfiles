set nocompatible
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
" Enable file type plugins
filetype plugin on
" Read the file again when changed outside
set autoread
" Use enhanced command completion
set wildmode=longest,full
set wildmenu
" Show word completion
set completeopt=longest,menuone,preview
" Ignore some file types
set wildignore+=*.o,*.pdf
" Highlight search results
set hlsearch
" Search while typing
set incsearch
" If the search string contains uppercase letters do not ignore case
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
" Remove annoying buttons in gui mode
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
colorscheme badwolf
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
inoremap jk <Esc>
" Fast way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" New windows are below or right
set splitbelow
set splitright
" Save viminfo somewhere else
set viminfo+=n~/.vim/viminfo
" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Enable spell checking
set spell
" Visually wrap long lines
set wrap
" Number of line above and below the cursor
set scrolloff=5
" Define leader key
let mapleader=" "
" Fast file saving
noremap <leader>s :w<cr>
" Show end of lines
set colorcolumn=80
" Always show status line
set laststatus=2
" Double newline (useful in various cases)
imap <c-j> <cr><cr>
