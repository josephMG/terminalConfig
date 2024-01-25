call plug#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plug 'VundleVim/Vundle.vim'
"Plug 'lepture/vim-css' " Css3 Syntax
Plug 'hail2u/vim-css3-syntax' "CSS3 Syntax
Plug 'othree/html5.vim' " HTML5 Syntax
Plug 'othree/yajs.vim' " ES6 Syntax
Plug 'ap/vim-css-color'
Plug 'JulesWang/css.vim' " only necessary if your Vim version < 7.4
Plug 'cakebaker/scss-syntax.vim'
Plug 'flazz/vim-colorschemes'
"Plug 'https://github.com/gorodinskiy/vim-coloresque.git'
Plug 'mattn/emmet-vim'
"Plug 'kchmck/vim-coffee-script'
"Plug 'mtscout6/vim-cjsx'
"Plug 'storyn26383/vim-vue'
"Plug 'digitaltoad/vim-pug'
"Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'chemzqm/vim-jsx-improve'
"Plug 'mxw/vim-jsx'
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'dense-analysis/ale'
"Plug 'mattn/vim-lsp-settings'

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" The following are examples of different formats supported.
" Keep Plug commands between vundle#begin/end.
" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
" Git plugin not hosted on GitHub
Plug 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
""""Plug 'file:///home/gmarik/path/to/plugin'
Plug 'preservim/nerdtree'
"Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'shawncplus/phpcomplete.vim'
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'TovarishFin/vim-solidity'

" yarn install && yarn add prettier-plugin-solidity
Plug 'prettier/vim-prettier'
call plug#end()
