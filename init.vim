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
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
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


" ===============================
" ALE configuration
let g:ale_sign_column_always = 1
let g:ale_fixers = {
      \ '*':          ['remove_trailing_lines', 'trim_whitespace'],
      \ 'erb':        ['erblint'],
      \ 'ruby':       ['rubocop'],
      \ 'html':       ['prettier'],
      \ 'css':        ['prettier'],
      \ 'sass':       ['prettier'],
      \ 'scss':       ['prettier'],
      \ 'javascript': ['prettier','eslint'],
      \ 'typescript': ['prettier','eslint'],
      \ 'markdown':   ['prettier'],
      \ 'lua':        ['luafmt'],
      \ 'rust':       ['rustfmt']}
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1
" let g:ale_completion_enabled = 1
let g:ale_echo_msg_format = '%linter% says %s'
" let g:ale_completion_autoimport = 1

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

" LSP config
" ===============================
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

" Galaxyline configuration
" ===============================
lua << EOF
local gl = require('galaxyline')
-- get my theme in galaxyline repo
-- local colors = require('galaxyline.theme').default
local colors = {
    -- bg = '#2E2E2E',
    bg = '#292D38',
    yellow = '#DCDCAA',
    dark_yellow = '#D7BA7D',
    cyan = '#4EC9B0',
    green = '#608B4E',
    light_green = '#B5CEA8',
    string_orange = '#CE9178',
    orange = '#FF8800',
    purple = '#C586C0',
    magenta = '#D16D9E',
    grey = '#858585',
    blue = '#569CD6',
    vivid_blue = '#4FC1FF',
    light_blue = '#9CDCFE',
    red = '#D16969',
    error_red = '#F44747',
    info_yellow = '#FFCC66'
}
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}

gls.left[1] = {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local mode_color = {
                n = colors.blue,
                i = colors.green,
                v = colors.purple,
                [''] = colors.purple,
                V = colors.purple,
                c = colors.magenta,
                no = colors.blue,
                s = colors.orange,
                S = colors.orange,
                [''] = colors.orange,
                ic = colors.yellow,
                R = colors.red,
                Rv = colors.red,
                cv = colors.blue,
                ce = colors.blue,
                r = colors.cyan,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!'] = colors.blue,
                t = colors.blue
            }
            vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()])
            return '▊ '
        end,
        highlight = {colors.red, colors.bg}
    }
}
print(vim.fn.getbufvar(0, 'ts'))
vim.fn.getbufvar(0, 'ts')

gls.left[2] = {
    GitIcon = {
        provider = function()
            return ' '
        end,
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.orange, colors.bg}
    }
}

gls.left[3] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.left[4] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.green, colors.bg}
    }
}
gls.left[5] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = ' 柳',
        highlight = {colors.blue, colors.bg}
    }
}
gls.left[6] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.red, colors.bg}
    }
}

gls.right[1] = {
    DiagnosticError = {provider = 'DiagnosticError', icon = '  ', highlight = {colors.error_red, colors.bg}}
}
gls.right[2] = {DiagnosticWarn = {provider = 'DiagnosticWarn', icon = '  ', highlight = {colors.orange, colors.bg}}}

gls.right[3] = {
    DiagnosticHint = {provider = 'DiagnosticHint', icon = '  ', highlight = {colors.vivid_blue, colors.bg}}
}

gls.right[4] = {DiagnosticInfo = {provider = 'DiagnosticInfo', icon = '  ', highlight = {colors.info_yellow, colors.bg}}}

gls.right[5] = {
    ShowLspClient = {
        provider = 'GetLspClient',
        condition = function()
            local tbl = {['dashboard'] = true, [' '] = true}
            if tbl[vim.bo.filetype] then return false end
            return true
        end,
        icon = ' ',
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[6] = {
    LineInfo = {
        provider = 'LineColumn',
        separator = '  ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[7] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highligt = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[8] = {
    Tabstop = {
        provider = function()
            return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
        end,
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[9] = {
    BufferType = {
        provider = 'FileTypeName',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[10] = {
    FileEncode = {
        provider = 'FileEncode',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[11] = {
    Space = {
        provider = function()
            return ' '
        end,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.orange, colors.bg}
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = 'FileTypeName',
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.short_line_left[2] = {
    SFileName = {provider = 'SFileName', condition = condition.buffer_not_empty, highlight = {colors.grey, colors.bg}}
}

gls.short_line_right[1] = {BufferIcon = {provider = 'BufferIcon', highlight = {colors.grey, colors.bg}}}
EOF
