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
" Plug 'danilo-augusto/vim-afterglow'  "load the afterglow theme
Plug 'joshdick/onedark.vim' " Onedark color scheme
Plug 'tpope/vim-surround'  "ysat: you surround all text
Plug 'tpope/vim-repeat'    "plugin commands are repeatable
Plug 'tpope/vim-commentary'  "easy commenting
Plug 'tpope/vim-rails'  "rails specific commands
Plug 'tpope/vim-fugitive'  "easy git commands
" Plug 'tpope/vim-vinegar'  " file browser
Plug 'kien/ctrlp.vim'  "fuzzy finding search file
Plug 'vim-ruby/vim-ruby'  " ruby support including gf : goto file
Plug 'ervandew/ag'  " searching within documents for keywords
" Plug 'w0rp/ale' " syntax checking/ linter support<Paste>
" Plug 'ap/vim-css-color', {'for': ['css', 'scss']} "colors hex values in their corresponding color
Plug 'norcalli/nvim-colorizer.lua' "colorizer
" Plug 'pangloss/vim-javascript', {'for': 'javascript'}    " JavaScript support
" Plug 'leafgarland/typescript-vim', {'for': 'typescript'} " TypeScript syntax
Plug 'mattn/emmet-vim', {'for': [ 'html', 'eruby', 'elixir']} " provides html snippets
" Plug 'vim-airline/vim-airline'
Plug 'hoob3rt/lualine.nvim'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'unblevable/quick-scope'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
" Plug 'nvim-lua/completion-nvim'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'airblade/vim-gitgutter'
Plug 'sbdchd/neoformat'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
" Plug 'liuchengxu/vim-which-key'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'junegunn/fzf'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/nvim-compe' "for completion
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
"       \ 'rust':       ['rust-analyzer']}
" let g:ale_lint_on_enter = 0
" let g:ale_fix_on_save = 1
" let g:ale_completion_enabled = 1
" let g:ale_echo_msg_format = '%linter% says %s'
" let g:ale_completion_autoimport = 1

"Airline configuration
let g:airline#extensions#ale#enabled = 1

" " ===============================
" " Deoplete config
" let g:deoplete#enable_at_startup = 1

" " Enables Tab completion
" function! s:check_back_space() abort "{{{
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~ '\s'
" endfunction"}}}
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ deoplete#manual_complete()
" " call deoplete#custom#source('ale', 'rank', 999)

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
autocmd BufReadPost *.rs setlocal filetype=rust

" Required for operations modifying multiple buffers like rename.
set hidden

" let g:LanguageClient_serverCommands = {
"       \ 'rust': ['rustup', 'run', 'nightly', 'rls'],}
"       \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
"       \ 'python': ['/usr/local/bin/pyls'],
"       \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
"       \ }

" Automatically start language servers.
" let g:LanguageClient_autoStart = 1

" Maps K to hover, gd to goto definition, F2 to rename
" nnoremap <silent> K :call LanguageClient_textDocument_hover()
" nnoremap <silent> gd :call LanguageClient_textDocument_definition()
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nmap <F5> <Plug>(lcn-menu)

" Elixir formatter
" ===============================
let g:mix_format_on_save = 1

" Whichkey configuration
" ===============================
" let g:mapleader = "\<Space>"
" let g:maplocalleader = ','
" nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
" nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" ===============================
" compe config
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

" ===============================
" Treesitter config

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
" ===============================
" LSP config

lua << EOF
local nvim_lsp = require("lspconfig")
-- General language server
nvim_lsp.efm.setup{}
-- Typescript language server
nvim_lsp.tsserver.setup{}
-- Ruby language server
nvim_lsp.solargraph.setup{}
-- Python language server
nvim_lsp.pyright.setup{}
-- CSS language server
nvim_lsp.cssls.setup{}
-- HTML language server
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.html.setup {
capabilities = capabilities,
}
-- JSON language server
nvim_lsp.jsonls.setup {
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}
-- Rust language server
nvim_lsp.rust_analyzer.setup{}
-- Lua language server
nvim_lsp.sumneko_lua.setup{}
-- TEX language server
-- nvim_lsp.texlab.setup{}
-- Vim language server
nvim_lsp.vimls.setup{}
-- YAML language server
nvim_lsp.yamlls.setup{}
EOF

luafile ~/.config/nvim/lua/lsp/lua-ls.lua

let g:lualine = {
      \'options' : {
      \  'theme' : 'nord',
      \  'section_separators' : ['', ''],
      \  'component_separators' : ['', ''],
      \  'icons_enabled' : v:true,
      \},
      \'sections' : {
      \  'lualine_a' : [ ['mode', {'upper': v:true,},], ],
      \  'lualine_b' : [ ['branch', {'icon': '',}, ], ],
      \  'lualine_c' : [ ['filename', {'file_status': v:true,},], ],
      \  'lualine_x' : [ 'encoding', 'fileformat', 'filetype' ],
      \  'lualine_y' : [ 'progress' ],
      \  'lualine_z' : [ 'location'  ],
      \},
      \'inactive_sections' : {
      \  'lualine_a' : [  ],
      \  'lualine_b' : [  ],
      \  'lualine_c' : [ 'filename' ],
      \  'lualine_x' : [ 'location' ],
      \  'lualine_y' : [  ],
      \  'lualine_z' : [  ],
      \},
      \'extensions' : [ 'fzf' ],
      \}
lua require("lualine").setup()
