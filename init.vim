syntax on
filetype plugin indent on
set relativenumber
set clipboard+=unnamedplus
set wildmenu
set cmdheight=2 " Sets height of command window

" Change tabs to 2 spaces
set expandtab
set tabstop=2
retab
set shiftwidth=2
" end tab settings

"remap jj to also be escape key
imap jj <Esc>

"remap leader to space
nnoremap <SPACE> <Nop>
let mapleader=" "

" ===============================
" Plugins
call plug#begin(stdpath('data') . '/plugged')
Plug 'cohama/lexima.vim' "auto close parenthesis
Plug 'alvan/vim-closetag', {'for': ['html','eruby', 'js']} "closes html brackets
Plug 'joshdick/onedark.vim' " Onedark color scheme
Plug 'tpope/vim-surround'  "ysat: you surround all text
Plug 'tpope/vim-repeat'    "plugin commands are repeatable
Plug 'tpope/vim-commentary'  "easy commenting
Plug 'tpope/vim-rails'  "rails specific commands
Plug 'tpope/vim-fugitive'  "easy git commands
Plug 'kien/ctrlp.vim'  "fuzzy finding search file
Plug 'vim-ruby/vim-ruby'  " ruby support including gf : goto file
Plug 'ervandew/ag'  " searching within documents for keywords
Plug 'norcalli/nvim-colorizer.lua' "colorizer
Plug 'mattn/emmet-vim', {'for': [ 'html', 'eruby', 'elixir']} " provides html snippets
Plug 'unblevable/quick-scope'
" Plug 'elixir-editors/vim-elixir'
" Plug 'mhinz/vim-mix-format'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'airblade/vim-gitgutter'
" Plug 'w0rp/ale'
Plug 'sbdchd/neoformat'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'junegunn/fzf'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/nvim-compe' "for completion
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

" ===============================
" Colorizer setup
set termguicolors

" ===============================
" Set Color Scheme
let g:onedark_color_overrides = {
\ "black": {"gui": "#010110", "cterm": "235", "cterm16": "0" },
\}
lua require'plug-colorizer'
colorscheme onedark

"Airline configuration
let g:airline#extensions#ale#enabled = 1

" ===============================
" Closetage config
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.html.erb'
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" ===============================
" Fuction key shortcuts
map <F3> :!ruby %<CR>
" note that if you are using Plug mapping you should not use `noremap` mappings.
nmap <F5> <Plug>(lcn-menu)
map <F6> :lopen<CR>
map <Leader><F6> :lclose<CR>
map <F7> :set relativenumber!<CR>:set number<CR>
map <F8> :Ag
map <Leader><F8> :copen<CR>
map <Leader><Right> :cnext<CR>
map <Leader><Left> :cprev<CR>

" File browser
nnoremap <leader>t :NvimTreeToggle<CR>
nnoremap <F4> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" Automatic formatter configuration
" ===============================
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
" ===============================
" ALE configuration
" let g:ale_sign_column_always = 1
" let g:ale_fixers = {
"       \ '*':          ['remove_trailing_lines', 'trim_whitespace'],
"       \ 'erb':        ['erblint'],
"       \ 'ruby':       ['rubocop'],
"       \ 'html':       ['prettier'],
"       \ 'css':        ['prettier'],
"       \ 'sass':       ['prettier'],
"       \ 'scss':       ['prettier'],
"       \ 'javascript': ['prettier','eslint'],
"       \ 'typescript': ['prettier','eslint'],
"       \ 'markdown':   ['prettier'],
"       \ 'lua':        ['luafmt'],
"       \ 'rust':       ['rustfmt']}
" let g:ale_lint_on_enter = 0
" let g:ale_fix_on_save = 1
" " let g:ale_completion_enabled = 1
" let g:ale_echo_msg_format = '%linter% says %s'
" " let g:ale_completion_autoimport = 1

" ===============================
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" ===============================
" Rust Language Server
" autocmd BufReadPost *.rs setlocal filetype=rust

" Required for operations modifying multiple buffers like rename.
set hidden

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Elixir formatter
" ===============================
let g:mix_format_on_save = 1

" compe config -autocomplete
" ===============================
lua <<EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}
EOF

" Treesitter config
" ===============================
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
  indent = {
  enable = true,
  },
  autotag = {enable = true}
}
EOF


luafile ~/.config/nvim/lua/lsp/lsp_configs.lua
luafile ~/.config/nvim/galaxyline.lua
luafile ~/.config/nvim/lua/lsp/lua-ls.lua
