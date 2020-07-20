set encoding=utf-8
set nocompatible              " be iMproved, required
filetype off                  " required

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Plugin 'lepture/vim-css' " Css3 Syntax
Plugin 'hail2u/vim-css3-syntax' "CSS3 Syntax
Plugin 'othree/html5.vim' " HTML5 Syntax
Plugin 'othree/yajs.vim' " ES6 Syntax
Plugin 'ap/vim-css-color'
Plugin 'JulesWang/css.vim' " only necessary if your Vim version < 7.4
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'flazz/vim-colorschemes'
"Plugin 'https://github.com/gorodinskiy/vim-coloresque.git'
Plugin 'mattn/emmet-vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mtscout6/vim-cjsx'
Plugin 'storyn26383/vim-vue'
Plugin 'digitaltoad/vim-pug'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'chemzqm/vim-jsx-improve'
"Plugin 'mxw/vim-jsx'
" Plugin 'leafgarland/typescript-vim'
" Plugin 'peitalin/vim-jsx-typescript'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'ryanolsonx/vim-lsp-typescript'

Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'

Plugin 'https://github.com/fatih/vim-go.git'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
""""Plugin 'file:///home/gmarik/path/to/plugin'
Plugin 'preservim/nerdtree'
Plugin 'preservim/nerdcommenter'
" Plugin 'bagrat/vim-buffet'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Valloric/YouCompleteMe'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }


" All of your Plugins must be added before the following line
call vundle#end()            " required
"colorscheme edo_sea
colorscheme darkblue
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType go let g:go_fmt_command = "goimports"
filetype plugin indent on    " required

" phpcd setting
autocmd FileType php setlocal omnifunc=phpcd#CompletePHP
let g:phpcd_disable_static_filter = 1

" Emmet setting
autocmd FileType html,css,javascript.jsx,typescript.tsx EmmetInstall
let g:user_emmet_install_global = 0
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}
autocmd FileType html,css,javascript.jsx EmmetInstall
" NERDTree setting
map <F1> :NERDTreeToggle <CR>
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" NERD commenter setting
let g:NERDSpaceDelims = 1
let NERDTreeMapOpenInTab='<C-t>'
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}

" vim-buffet setting
" noremap <Tab> :bn<CR>
" noremap <S-Tab> :bp<CR>
" noremap <Leader><Tab> :Bw<CR>
" noremap <Leader><S-Tab> :Bw!<CR>
" noremap <C-t> :tabnew split<CR>
" let g:buffet_powerline_separators = 1
" let g:buffet_tab_icon = "\uf00a"
" let g:buffet_left_trunc_icon = "\uf0a8"
" let g:buffet_right_trunc_icon = "\uf0a9"
" function! g:BuffetSetCustomColors()
"     hi! BuffetCurrentBuffer guifg=blue guibg=darkgray gui=none ctermfg=darkblue ctermbg=gray term=none cterm=none
"     hi! BuffetActiveBuffer guifg=black guibg=darkgray gui=none ctermfg=black ctermbg=gray term=none cterm=none
"     hi! BuffetBuffer guifg=black guibg=darkgray gui=none ctermfg=black ctermbg=lightgreen term=none cterm=none
" endfunction

" vim-lsp
highlight LspErrorHighlight ctermfg=red guifg=red ctermbg=green guibg=green
highlight LspWarningHighlight ctermfg=red guifg=red ctermbg=green guibg=green
"highlight LspInformationHighlight term=underline cterm=underline gui=underline
highlight LspHintHighlight term=underline cterm=underline gui=underline
highlight LspWarningLine ctermfg=red guifg=red ctermbg=green guibg=green
"highlight link LspHintVirtual Error
" highlight LspErrorText term=underline cterm=underline gui=underline
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_hint = {'text': '!!'}
let g:lsp_highlights_enabled = 1
let g:lsp_textprop_enabled = 1
nmap \gd :tab LspDefinition<cr>
" let g:lsp_virtual_text_enabled = 0
" highlight clear LspWarningLine
" highlight clear LspErrorVirtual
" highlight clear LspErrorText
" let g:lsp_highlight_references_enabled = 0
" highlight lspReference ctermfg=red guifg=red ctermbg=green guibg=green

"" typescript
""":set filetype?
"yats
"autocmd BufNewFile,BufRead *.ts set filetype=typescriptreact
au FileType typescript.tsx,typescriptreact,typescript call TypescriptExtend()
"au Syntax *.tsx,*.ts call TypescriptExtend()
function TypescriptExtend()
  "  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
"  autocmd VimEnter * echo 'foo'

  " syntax cluster javascriptNoReserved            contains=@javascriptStrings,@javascriptDocs,shellbang,javascriptObjectLiteral,javascriptParenObjectLiteral,javascriptObjectLabel,javascriptClassBlock,javascriptMethodName,javascriptMethod 
  " syntax match   javascriptObjectLabel           contained /\k\+\_s*?\?:/he=e-1 contains=javascriptObjectLabelColon nextgroup=@javascriptComments,@javascriptValue,@javascriptStatement,@typescriptAll skipwhite skipempty
  " syntax match   javascriptObjectLabelColon      contained /\s*:/ nextgroup=@javascriptValue skipwhite skipempty

  " syntax region  javascriptObjectLiteral         matchgroup=javascriptBraces start=/{/ end=/}/ contains=@javascriptComments,javascriptObjectLabel,javascriptComma,@javascriptObjectMethod,javascriptPropertyNameString,javascriptComputedPropertyName,@javascriptValue fold
  " "syntax region  javascriptObjectLiteral         matchgroup=javascriptBraces start=/{/ end=/}/ contains=@javascriptComments,javascriptObjectLabel,javascriptComma,javascriptPropertyNameString,javascriptComputedPropertyName fold

  " syntax region  javascriptParenObjectLiteral    contained start=/(\_s*\ze{/ end=/)/ contains=javascriptObjectLiteral,@javascriptComments transparent fold
  " syntax cluster javascriptStatement contains=javascriptBlock,javascriptVariable,@javascriptExpression,javascriptConditional,javascriptRepeat,javascriptBranch,javascriptLabel,javascriptStatementKeyword,javascriptTry,javascriptDebugger
  " syntax cluster javascriptValue contains=@javascriptTypes,@javascriptExpression,javascriptFuncKeyword,javascriptClassKeyword,javascriptObjectLiteral,javascriptIdentifier,javascriptIdentifierName,javascriptOperator,javascriptOpSymbols
  " syntax region  javascriptPropertyNameString    contained start=/\z(["']\)/  skip=/\\\\\|\\\z1\|\\\n/  end=/\z1\|$/ nextgroup=javascriptObjectLabelColon,javascriptFuncArg skipwhite skipempty

  " syntax match   javascriptSyncFunc              contained /\s*/ nextgroup=javascriptFuncName,javascriptFuncArg
  " syntax match   javascriptAsyncFunc             contained /\s*\*\s*/ nextgroup=javascriptFuncName,javascriptFuncArg skipwhite skipempty
  " syntax match   javascriptFuncName              contained /[a-zA-Z_$]\k*/ nextgroup=javascriptFuncArg skipwhite
  " syntax region  javascriptFuncArgArray          contained matchgroup=javascriptBrackets start=/\[/ end=/]/ contains=@javascriptFuncArgElements transparent
  " syntax region  javascriptFuncArgObject         contained matchgroup=javascriptBraces start=/{/ end=/}/ contains=@javascriptFuncArgElements transparent
  " syntax cluster javascriptFuncArgElements contains=javascriptFuncKeyword,javascriptComma,javascriptDefaultAssign,@javascriptComments,javascriptFuncArgArray,javascriptFuncArgObject,javascriptSpreadOp
  " syntax region  javascriptFuncArg               contained matchgroup=javascriptParens start=/(/ end=/)/ contains=@javascriptFuncArgElements nextgroup=javascriptBlock skipwhite skipwhite skipempty

  " syntax match   javascriptArrowFuncDef          /(\_[^()]*)\_s*=>/ contains=javascriptArrowFuncArg,javascriptComma,javascriptArrowFunc nextgroup=@afterArrowFunc skipwhite skipempty
  " syntax match   javascriptArrowFuncDef          /[a-zA-Z_$]\k*\_s*=>/ contains=javascriptArrowFuncArg,javascriptArrowFunc nextgroup=@afterArrowFunc skipwhite skipempty
  " syntax match   javascriptArrowFunc             /=>/
  " syntax match   javascriptArrowFuncArg          contained /[a-zA-Z_$]\k*/
  " syntax region  javascriptArrowFuncArg          contained matchgroup=javascriptParens start=/(/ end=/)/ contains=@javascriptFuncArgElements nextgroup=javascriptArrowFunc skipwhite skipempty
  " syntax match   javascriptAsynArrowFunc         /(\s*async\s*\(=>\)\@!/ contains=javascriptAsyncFuncKeyword
  
  hi Special ctermfg=yellow
  "" dark red
  hi tsxTag ctermfg=lightblue guifg=#E06C75
  hi tsxTagName ctermfg=lightblue guifg=#E06C75
  hi tsxIntrinsicTagName ctermfg=lightblue guifg=#E06C75
  "" orange
  hi tsxCloseString ctermfg=lightblue guifg=#F99575
  hi tsxCloseTag ctermfg=lightblue guifg=#F99575
  hi tsxCloseTagName ctermfg=yellow guifg=#F99575
  hi tsxAttributeBraces ctermfg=brown guifg=#F99575
  hi tsxEqual ctermfg=yellow guifg=#F99575
  " light-grey
  hi tsxTypeBraces ctermfg=brown guifg=#999999
  " dark-grey
  hi tsxTypes ctermfg=204 guifg=#666666
  "" yellow
  hi tsxAttrib ctermfg=green guifg=#F8BD7F cterm=italic
  hi ReactState ctermfg=204 guifg=#C176A7
  hi ReactProps ctermfg=204 guifg=#D19A66
  hi ApolloGraphQL ctermfg=204 guifg=#CB886B
  hi Events ctermfg=204 guifg=#56B6C2
  hi ReduxKeywords ctermfg=204 guifg=#C678DD
  hi ReduxHooksKeywords ctermfg=204 guifg=#C176A7
  hi WebBrowser ctermfg=204 guifg=#56B6C2
  hi ReactLifeCycleMethods ctermfg=204 guifg=#D19A66
endfun


" vim-airline setting
let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#tabnr_formatter = 'tabnr'
nnoremap <S-Tab> :tabprevious<CR>
nnoremap <Tab>   :tabnext<CR>
nnoremap <Leader>Q :bdelete<CR>
nnoremap <C-Left> :-tabmove<CR>
nnoremap <C-Right> :+tabmove<CR>

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

if &diff
"	colorscheme random
  highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
endif
