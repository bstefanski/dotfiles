" List all plugins here.
"
" Configurations for plugins should be defined in plugin-config.vim
call plug#begin()

Plug 'tpope/vim-sensible'               " Some sensible settings
Plug 'tpope/vim-sleuth'                 " Autodetect file spacing
Plug 'scrooloose/nerdcommenter'         " Awesome Commenting
Plug 'vim-scripts/auto-pairs-gentle'    " Add brackets automatically
Plug 'vim-scripts/autoswap.vim'         " Handle swap files intelligently
Plug 'sheerun/vim-polyglot'             " Mega language support pack
Plug 'liuchengxu/vista.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sainnhe/edge'
Plug 'ntk148v/vim-horizon'
Plug 'ruby-formatter/rufo-vim'
Plug 'tpope/vim-fugitive'               " Git wrapper
Plug 'itchyny/lightline.vim'            " Awesome status bar
Plug 'neomake/neomake'                  " Syntax checking
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'    " .editorconfig support
Plug 'tpope/vim-surround'               " Change your surroundings
Plug 'terryma/vim-multiple-cursors'     " Multiple cursors
Plug 'Yggdroot/indentLine'              " Indent guides
Plug 'easymotion/vim-easymotion'        " Navigate files with ease
Plug 'scrooloose/nerdtree'              " File tree view
Plug 'janko-m/vim-test'                 " Running tests
Plug 'airblade/vim-gitgutter'           " Git gutter
Plug 'junegunn/vim-easy-align'          " Align things
Plug 'mattn/emmet-vim'                  " Expanding abbreviations
Plug 'Mofiqul/dracula.nvim'
Plug 'dracula/vim', { 'as': 'draculaV' }

call plug#end()
