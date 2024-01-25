
set encoding=utf-8
set nocompatible              " be iMproved, required
filetype off                  " required
"colorscheme edo_sea
colorscheme darkblue

filetype plugin indent on    " required
set t_Co=256
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
"set laststatus=0
set cursorline
set wrap
set linebreak
"set term=xterm-256color
"set statusline=%4*%<\%m%<[%f\%r%h%w]\ [%{&ff},%{&fileencoding},%Y]%=\[Position=%l,%v,%p%%]
"

" powerline zsh
set laststatus=2
set hlsearch

" MacOS settings
syntax enable
set backspace=indent,eol,start

" show spaces as dots
set listchars=space:·,tab:!·
set list

" setqflist to open in new tab
set switchbuf+=usetab,newtab

if &diff
"	colorscheme random
  highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
endif
