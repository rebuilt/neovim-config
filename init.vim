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
set updatetime=500

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
Plug 'Krasjet/auto.pairs'
Plug 'alvan/vim-closetag', {'for': ['html','eruby', 'js']} "closes html brackets
Plug 'joshdick/onedark.vim' " Onedark color scheme
Plug 'tpope/vim-surround'  "ysat: you surround all text
Plug 'tpope/vim-repeat'    "plugin commands are repeatable
Plug 'tpope/vim-commentary'  "easy commenting
Plug 'tpope/vim-fugitive'  "easy git commands
Plug 'norcalli/nvim-colorizer.lua' "colorizer
Plug 'unblevable/quick-scope' " highlight unique letter on a line for quick line navigation
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'sbdchd/neoformat'
" Language client
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Status bar 
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
" File browser and dependencies
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
" Telescope and its dependencies
Plug 'kyazdani42/nvim-web-devicons' " icons
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mfussenegger/nvim-jdtls'
" Auto-completion and dependencies
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'nvim-lua/completion-nvim'

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
" nnoremap <leader>ff <cmd>Telescope fzy_native<cr>
nnoremap <F8> <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" File browser
nnoremap <leader>t :NvimTreeToggle<CR>
let g:ranger_map_keys = 0
nnoremap <F4> :Ranger<CR>
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

luafile ~/.config/nvim/lua/galaxyline/galaxyline.lua
luafile ~/.config/nvim/lua/telescope/telescope.lua
" luafile ~/.config/nvim/lua/lsp/compe.lua
luafile ~/.config/nvim/lua/lsp/treesitter.lua
luafile ~/.config/nvim/lua/lsp/lsp_configs.lua
luafile ~/.config/nvim/lua/lsp/lua-ls.lua
luafile ~/.config/nvim/lua/lsp/emmet.lua

"Auto-Completion options
" ===============================
lua require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}
" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()
let g:completion_enable_snippet = 'vim-vsnip'

set completeopt=menuone,noinsert,noselect,preview
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Avoid showing message extra message when using completion
set shortmess+=c
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

