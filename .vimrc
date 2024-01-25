
source $HOME/.vim/init/plug.vimrc
source $HOME/.vim/init/general.vimrc
source $HOME/.vim/init/functions.vimrc
source $HOME/.vim/init/coc_init.vimrc

autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

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

""" YouCompleteMe setting
"nmap<Leader>F :YcmCompleter FixIt<CR>

" vim-lsp
highlight LspErrorHighlight term=underline cterm=underline gui=underline
highlight LspWarningHighlight ctermfg=red guifg=red ctermbg=green guibg=green
"highlight LspInformationHighlight term=underline cterm=underline gui=underline
highlight LspHintHighlight term=underline cterm=underline gui=underline
highlight LspWarningLine ctermfg=red guifg=red ctermbg=green guibg=green
"highlight link LspHintVirtual Error
"highlight LspErrorText term=underline cterm=underline gui=underline
" let g:lsp_diagnostics_enabled = 0
let g:lsp_signs_error = {'text': 'XX'}
let g:lsp_signs_hint = {'text': '!!'}
let g:lsp_highlights_enabled = 1
let g:lsp_textprop_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server']
"nmap \gd :tab LspDefinition<cr>
"nmap \gg :LspDocumentDiagnostics<cr>

" typescript
""":set filetype?
"yats
"autocmd BufNewFile,BufRead *.ts set filetype=typescriptreact
au FileType typescript.tsx,typescriptreact,typescript call TypescriptExtend()
"au Syntax *.tsx,*.ts call TypescriptExtend()

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
nnoremap <M-Left> :-tabmove<CR>
nnoremap <M-Right> :+tabmove<CR>

""" vim-prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.sol Prettier
"autocmd BufWritePre *.sol,*.tsx Prettier


" vim-ale
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_completion_autoimport = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint', 'tsserver'],
\   'typescriptreact': ['eslint', 'tsserver'],
\   'solidity': ['solhint'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'typescriptreact': ['eslint'],
\}
let g:ale_typescript_tslint_executable = 'eslint'

""" ale for Yarn v3
let s:sdks = finddir('.yarn/sdks', ';')
let g:ale_disable_lsp = 1
if !empty(s:sdks)
  let g:ale_javascript_tsserver_use_global = 1
  let g:ale_typescript_tsserver_executable = s:sdks . '/typescript/bin/tsserver'
  let g:ale_javascript_eslint_use_global = 1
  let g:ale_javascript_eslint_executable = 'yarn'
  let g:ale_javascript_eslint_options = 'run eslint'
  "let g:ale_javascript_eslint_executable = s:sdks . '/eslint/bin/eslint.js'
  let g:ale_javascript_prettier_use_global = 1
  let g:ale_javascript_flow_ls_executable = s:sdks . '/flow-bin/cli.js'
  let g:ale_javascript_prettier_use_global = 1
  let g:ale_javascript_prettier_executable = s:sdks . '/prettier/index.js'
endif
" let g:ale_solidity_solc_options = '--allow-paths *'
" highlight clear SpellBad
highlight SpellBad ctermfg=000 ctermbg=167 guifg=#ff0000 guibg=#ffff00
" highlight link ALEError SpellBad

" vim-go
autocmd FileType go let g:go_fmt_command = "goimports"
let g:go_doc_popup_window = 1
let g:go_def_reuse_buffer = 1
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
