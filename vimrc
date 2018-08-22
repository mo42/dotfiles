set nocompatible
filetype off
" Set up Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'takac/vim-hardtime'
Plugin 'pangloss/vim-javascript'
Plugin 'posva/vim-vue'
Plugin 'w0rp/ale'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'chrisbra/csv.vim'
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
let g:rehash256 = 1
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
set scrolloff=0
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
" Remove trailing white space
map <leader>s :%s/\s\+$//e<cr>
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
set spelllang=en
function! s:insert_guards()
  let guardname = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . guardname
  execute "normal! o#define " . guardname . " "
  execute "normal! Go#endif /* " . guardname . " */"
  normal! ko
endfunction
autocmd BufNewFile *.{h,hpp} call <sid>insert_guards()
" Make ctrl-f directly available
map <leader>f <esc>:<c-f>
map <leader>e <esc>:e<space>
" Disable line numbering for copying content
map <leader>n :call NoNumber()<cr>
function NoNumber()
  set nonumber
  set norelativenumber
endfunction
let g:hardtime_default_on = 0
let g:hardtime_timeout = 8000
let g:hardtime_showmsg = 1
let g:hardtime_maxcount = 2
let g:hardtime_allow_different_key = 1
let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "x"]
let g:list_of_normal_keys += ["w", "b", "dd"]
" Plugin settings: vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
let g:ale_fixers = { 'javascript': ['eslint'], }
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
" Abbreviations
iab teh the
iab tath that
" Highlight bad words
highlight badWordsGroup ctermbg=red ctermfg=white
" German bad words
call matchadd('badWordsGroup', '\caber ')
call matchadd('badWordsGroup', '\calso ')
call matchadd('badWordsGroup', '\caufgezeigt ')
call matchadd('badWordsGroup', '\cbekanntlich ')
call matchadd('badWordsGroup', '\cbestimmt ')
call matchadd('badWordsGroup', '\cbeziehungsweise ')
call matchadd('badWordsGroup', '\cbloß ')
call matchadd('badWordsGroup', '\cdoch ')
call matchadd('badWordsGroup', '\cdurchaus ')
call matchadd('badWordsGroup', '\ceben ')
call matchadd('badWordsGroup', '\ceher ')
call matchadd('badWordsGroup', '\ceinfach ')
call matchadd('badWordsGroup', '\ceinigermaßen ')
call matchadd('badWordsGroup', '\cerfolgt ')
call matchadd('badWordsGroup', '\cerstere ')
call matchadd('badWordsGroup', '\cetwa ')
call matchadd('badWordsGroup', '\cformal ')
call matchadd('badWordsGroup', '\cfreilich ')
call matchadd('badWordsGroup', '\cgar ')
call matchadd('badWordsGroup', '\cgenau ')
call matchadd('badWordsGroup', '\cgerade')
call matchadd('badWordsGroup', '\chalt ')
call matchadd('badWordsGroup', '\chauptsächlich')
call matchadd('badWordsGroup', '\cimmerhin ')
call matchadd('badWordsGroup', '\cjedenfalls ')
call matchadd('badWordsGroup', '\cjedoch ')
call matchadd('badWordsGroup', '\ckonkret ')
call matchadd('badWordsGroup', '\clediglich ')
call matchadd('badWordsGroup', '\cletztere ')
call matchadd('badWordsGroup', '\cletztlich ')
call matchadd('badWordsGroup', '\cmach')
call matchadd('badWordsGroup', 'mal')
call matchadd('badWordsGroup', '\cnatürlich ')
call matchadd('badWordsGroup', '\cnormalerweise ')
call matchadd('badWordsGroup', '\cnun ')
call matchadd('badWordsGroup', '\cnämlich ')
call matchadd('badWordsGroup', '\cobwohl ')
call matchadd('badWordsGroup', '\coffenbar ')
call matchadd('badWordsGroup', '\cprofund ')
call matchadd('badWordsGroup', '\cprozess des ')
call matchadd('badWordsGroup', '\cschließlich ')
call matchadd('badWordsGroup', '\cschon ')
call matchadd('badWordsGroup', '\csehr')
call matchadd('badWordsGroup', '\cselbstverständlich ')
call matchadd('badWordsGroup', '\csicherlich ')
call matchadd('badWordsGroup', '\cso ')
call matchadd('badWordsGroup', '\csolch')
call matchadd('badWordsGroup', '\csozusagen ')
call matchadd('badWordsGroup', '\cstreng genommen ')
call matchadd('badWordsGroup', '\ctatsächlich ')
call matchadd('badWordsGroup', '\ctraditionell ')
call matchadd('badWordsGroup', '\ctrotzdem ')
call matchadd('badWordsGroup', '\ctypisch')
call matchadd('badWordsGroup', '\cunbedingt ')
call matchadd('badWordsGroup', '\cverfügt ')
call matchadd('badWordsGroup', '\cvöllig ')
call matchadd('badWordsGroup', '\cwahrscheinlich ')
call matchadd('badWordsGroup', '\cwobei ')
call matchadd('badWordsGroup', '\cwohl ')
call matchadd('badWordsGroup', '\cüberhaupt ')
call matchadd('badWordsGroup', '\cüberwiegend ')
call matchadd('badWordsGroup', '\cüblicherweise ')
" English bad words
call matchadd('badWordsGroup', '\cactually')
call matchadd('badWordsGroup', '\calso')
call matchadd('badWordsGroup', '\caspect')
call matchadd('badWordsGroup', '\cin fact')
call matchadd('badWordsGroup', '\csome ')
call matchadd('badWordsGroup', '\ctruly ')
call matchadd('badWordsGroup', '\cvery')
call matchadd('badWordsGroup', '\ctypically')
call matchadd('badWordsGroup', '\csometimes')
