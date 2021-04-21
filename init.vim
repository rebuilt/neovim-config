syntax on
filetype plugin indent on
set relativenumber
set clipboard+=unnamedplus
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

set cmdheight=2 " Sets height of command window

" Change tabs to 2 spaces
set expandtab
set tabstop=2
retab
set shiftwidth=2
" end tab settings

" Required for operations modifying multiple buffers like rename.
set hidden

"remap jj to also be escape key
imap jj <Esc>

"remap leader to space
nnoremap <SPACE> <Nop>
let mapleader=" "

" ===============================
" Plugins
call plug#begin(stdpath('data') . '/plugged')
Plug 'liuchengxu/vista.vim'
Plug 'cohama/lexima.vim' "auto close parenthesis
Plug 'alvan/vim-closetag', {'for': ['html','eruby', 'js']} "closes html brackets
Plug 'joshdick/onedark.vim' " Onedark color scheme
Plug 'tpope/vim-surround'  "ysat: you surround all text
Plug 'tpope/vim-repeat'    "plugin commands are repeatable
Plug 'tpope/vim-commentary'  "easy commenting
Plug 'tpope/vim-rails'  "rails specific commands
Plug 'tpope/vim-fugitive'  "easy git commands
Plug 'tpope/vim-endwise' " adds the end keyword automatically
Plug 'vim-ruby/vim-ruby'  " ruby support including gf : goto file
Plug 'norcalli/nvim-colorizer.lua' "colorizer
Plug 'mattn/emmet-vim', {'for': [ 'html', 'eruby', 'elixir']} " provides html snippets
Plug 'unblevable/quick-scope' " highlight unique letter on a line for quick line navigation
Plug 'airblade/vim-gitgutter'
Plug 'sbdchd/neoformat'
Plug 'Yggdroot/indentLine' 
" Language client
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe' "for completion
" Tab line
Plug 'romgrk/barbar.nvim'
" Status bar 
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
" File browser
Plug 'kyazdani42/nvim-tree.lua'
" Telescope and its dependencies
Plug 'kyazdani42/nvim-web-devicons' " icons
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

" ===============================
" Colorizer setup
set termguicolors

" ===============================
"Set Color Scheme
let g:onedark_color_overrides = {
\ "black": {"gui": "#010110", "cterm": "235", "cterm16": "0" },
\}
lua require'plug-colorizer'
colorscheme onedark

" ===============================
" Vista setup
let g:vista_close_on_jump = 1
let g:vista_blink = [3,100]

set termguicolors
" ===============================
" Closetage config
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.html.erb'
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" ===============================
" Fuction key shortcuts
nmap <F2> :Vista!!<CR>
map <F3> :!ruby %<CR>
" note that if you are using Plug mapping you should not use `noremap` mappings.
nmap <F5> <Plug>(lcn-menu)
map <F6> :lopen<CR>
map <Leader><F6> :lclose<CR>
map <F7> :set relativenumber!<CR>:set number<CR>
map <Leader><F8> :copen<CR>
map <Leader><Right> :cnext<CR>
map <Leader><Left> :cprev<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <c-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <F8> <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" File browser
nnoremap <leader>t :NvimTreeToggle<CR>
nnoremap <F4> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>

" Tabs
nnoremap <TAB> :BufferNext<CR>
nnoremap <S-TAB> :BufferPrevious<CR>
nnoremap <S-x> :BufferClose<CR>

" Automatic formatter configuration
" ===============================
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

set completeopt=menuone,noinsert,noselect,preview
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

luafile ~/.config/nvim/lua/galaxyline/galaxyline.lua
luafile ~/.config/nvim/lua/lsp/compe.lua
luafile ~/.config/nvim/lua/lsp/treesitter.lua
luafile ~/.config/nvim/lua/lsp/lsp_configs.lua
luafile ~/.config/nvim/lua/lsp/lua-ls.lua
