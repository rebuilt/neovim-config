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
Plug 'vim-ruby/vim-ruby'  " ruby support including gf : goto file
Plug 'ervandew/ag'  " searching within documents for keywords
Plug 'norcalli/nvim-colorizer.lua' "colorizer
Plug 'mattn/emmet-vim', {'for': [ 'html', 'eruby', 'elixir']} " provides html snippets
Plug 'unblevable/quick-scope'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'airblade/vim-gitgutter'
Plug 'sbdchd/neoformat'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
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
map <c-p> :FZF<CR>
map <c-P> :FZF<CR>

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
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Required for operations modifying multiple buffers like rename.
set hidden

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

luafile ~/.config/nvim/galaxyline.lua
luafile ~/.config/nvim/lua/lsp/compe.lua
luafile ~/.config/nvim/lua/lsp/treesitter.lua
luafile ~/.config/nvim/lua/lsp/lsp_configs.lua
luafile ~/.config/nvim/lua/lsp/lua-ls.lua
