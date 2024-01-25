function TypescriptExtend()
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
  " yellow
  hi tsxAttrib ctermfg=green guifg=#F8BD7F cterm=italic
  hi ReactState ctermfg=204 guifg=#C176A7
  hi ReactProps ctermfg=204 guifg=#D19A66
  hi ApolloGraphQL ctermfg=204 guifg=#CB886B
  hi Events ctermfg=204 guifg=#56B6C2
  hi ReduxKeywords ctermfg=204 guifg=#C678DD
  hi ReduxHooksKeywords ctermfg=204 guifg=#C176A7
  hi WebBrowser ctermfg=204 guifg=#56B6C2
  hi ReactLifeCycleMethods ctermfg=204 guifg=#D19A66
  if executable('typescript-language-server')
    " echo lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx', 'typescriptreact'],
        \ })
  endif
endfun
