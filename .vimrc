" Minimal vim config. Cursor is the day-to-day editor; vim is for commit
" messages, quick edits and remote shells, so this stays dependency-free.
" (The old config called pathogen#infect() and loaded a `cobalt` colorscheme
" that was never installed, which errored on every start.)

set nocompatible
syntax on
filetype plugin indent on

" --- ui ------------------------------------------------------------------
set number              " line numbers
set cursorline          " highlight the current line
set showcmd             " show the pending command
set showmode
set showmatch           " flash the matching bracket
set scrolloff=5         " keep 5 lines of context around the cursor
set laststatus=2        " always show the status line
set ruler
set colorcolumn=81      " visual guide at 80 characters
set termguicolors       " 24-bit colour in modern terminals
silent! colorscheme habamax   " ships with vim 9; silent! so vim 8 doesn't error

" --- editing -------------------------------------------------------------
set autoindent smartindent
set expandtab           " spaces, not tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set backspace=indent,eol,start
set clipboard=unnamed   " yank straight to the macOS clipboard

" --- search --------------------------------------------------------------
set hlsearch
set incsearch
set ignorecase
set smartcase           " ...unless the search has a capital in it

" --- files ---------------------------------------------------------------
set nobackup            " version control is the backup
set nowritebackup
set noswapfile
set autoread            " reload files changed outside vim
set undofile
set undodir=~/.vim/undo
silent! call mkdir(expand('~/.vim/undo'), 'p')

" --- behaviour -----------------------------------------------------------
set noerrorbells
set visualbell t_vb=
set mouse=a
set hidden              " allow switching away from a modified buffer
set wildmenu
set wildmode=longest:full,full

" --- keys ----------------------------------------------------------------
" Clear search highlighting.
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
" Move by screen line, not file line, when a line wraps.
nnoremap j gj
nnoremap k gk

" --- filetypes -----------------------------------------------------------
" Git wants the commit summary wrapped at 72.
autocmd FileType gitcommit setlocal textwidth=72 colorcolumn=73 spell
autocmd FileType markdown  setlocal textwidth=80 spell
autocmd FileType python    setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType go        setlocal noexpandtab
