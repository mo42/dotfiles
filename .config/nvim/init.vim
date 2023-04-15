" Set up Vundle
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin("~/.config/nvim/bundle")
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'takac/vim-hardtime'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mo42/badwords'
Plugin 'tomasr/molokai'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'luochen1990/rainbow'
Plugin 'mhinz/vim-signify'
call vundle#end()
" Plugin settings
" vim-hardtime
let g:hardtime_default_on = 1
let g:hardtime_timeout = 4000
let g:hardtime_showmsg = 0
let g:hardtime_maxcount = 2
let g:hardtime_allow_different_key = 1
let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "x", "~", "dw"]
let g:list_of_normal_keys += ["w", "b", "dd"]
let g:hardtime_motion_with_count_resets = 1
" rainbow
let g:rainbow_active = 1
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
set undoreload=100000
set undolevels=100000
set noswapfile
set nobackup
set nowritebackup
" Hide the mouse while typing
set mousehide
" Use two spaces instead of tabs
set expandtab
set shiftwidth=2
set tabstop=2
" Disable wrapping text as this is done by auto-formatting tools
set textwidth=0
" Automatically indent next line
set autoindent
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
" Automatically convert to Unix line endings
autocmd BufWrite * :set ff=unix
" Visually wrap long lines
set wrap
" Number of lines above and below the cursor
set scrolloff=5
" Define leader key
let mapleader=","
" Fast file saving
noremap <leader>w :w<cr>
" Look up help quickly
nnoremap <leader>h :help<cr>
" Close window
noremap <leader>x :x<cr>
" Repeat last colon command
map <leader>. @:
" Remove trailing white space
map <leader>s :%s/\s\+$//e<cr>
" Open zettelkasten index file
nnoremap <leader>z :e ~/zettelkasten/index.md<cr>:cd ~/zettelkasten/
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
iab GRUSSE Viele Grüße<cr>Moritz<esc>
iab REGARDS Kind regards,<cr>Moritz<esc>
iab MDLINK []()<esc>i
iab MDIMAGE ![]()<esc>i
iab PYDOC '''D.<cr><cr>Arguments:<cr>arg -- description<cr>returns -- description'''<esc>4ki
" Space scrolls down in normal mode
nmap <space> <pagedown>
nmap <c-space> <pageup>
" Regular vim format
map Q gqip
" Void annoying prompts
set shortmess=a
" Use make
map <c-m> :make<cr>
" Look for files in the entire subtree
set path+=**
" Enable spell checking
set spell
set spelllang=en
" Cycle through spell checkers
nnoremap <leader>l :call CycleSpellLanguage()<cr>
let g:current_spell_language = ''
function CycleSpellLanguage()
  let languages = ['', 'en_us', 'de_de']
  let i = (index(languages, g:current_spell_language) + 1) % len(languages)
  let g:current_spell_language = languages[i]
  call HighlightBadwords(g:current_spell_language)
  if empty(g:current_spell_language)
    set nospell
    echo 'No spell language'
  else
    set spell
    let &spelllang=g:current_spell_language
    echo 'Current spell language ' . g:current_spell_language
  endif
endfunction
" Make ctrl-f directly available
map <leader>c <esc>:<c-f>
map <leader>e <esc>:e<space>
map <leader>f <esc>:Files<cr>
" Disable line numbering for copying content
map <leader>n :call NoNumber()<cr>
function NoNumber()
  set nonumber
  set norelativenumber
endfunction
" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
" Abbreviations
iab teh the
iab tath that
iab goverment government
" LaTeX settings
augroup tex
  autocmd FileType tex setlocal wrap
  autocmd FileType tex setlocal linebreak
  autocmd FileType tex setlocal textwidth=0
  autocmd FileType tex setlocal iskeyword+=:
  autocmd FileType tex map <leader>t :w<cr> :!pdflatex %<cr>
  autocmd FileType tex call HighlightBadwords('en_us')
  autocmd FileType tex setlocal colorcolumn=0
augroup END
" Markdown settings
augroup md
  autocmd FileType md setlocal wrap
  autocmd FileType md setlocal linebreak
  autocmd FileType md setlocal textwidth=0
  autocmd FileType md call HighlightBadwords('en_us')
  autocmd FileType md setlocal colorcolumn=0
augroup END
set clipboard=unnamedplus
set shadafile=~/.config/nvim/shada
" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
set clipboard=unnamedplus
nnoremap <leader>* *#

" K[ moves to [ and enter insert mode
function! s:EditAt()
  let c = nr2char(getchar())
  exe "normal! f".c."l"
  startinsert
endfunction
noremap K :<c-u>call <SID>EditAt()<cr>
