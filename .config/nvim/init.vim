" Setup Vundle
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin("~/.config/nvim/bundle")
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'takac/vim-hardtime'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'mo42/badwords'
Plugin 'tomasr/molokai'
Plugin 'easymotion/vim-easymotion'
call vundle#end()
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
" Change mode quickly
inoremap jk <esc>
" Fast way to move between windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l
" Move between buffers
nnoremap <silent> <c-l> :bn<cr>
nnoremap <silent> <c-h> :bp<cr>
" Use enhanced command completion
set wildmode=longest,full
set wildmenu
" Show word completion
set completeopt=longest,menuone,preview
" Show specific characters
set list
set listchars=tab:>-,trail:·
" Ignore binary file types
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
" Enable syntax highlighting and colors
syntax enable
color molokai
" Default encoding
set encoding=utf8
" Enable undoing and disable backup and swap files
set undofile
set undodir=~/.config/nvim/undodir/
set undoreload=10000
set undolevels=10000
set noswapfile
set nobackup
set nowritebackup
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
" Allow unsaved buffers
set hidden
" Save 
shadafile=~/.config/nvim/shadafile
