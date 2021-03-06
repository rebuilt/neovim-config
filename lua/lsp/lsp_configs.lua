local nvim_lsp = require("lspconfig")

local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
vim.api.nvim_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>',
                        opts)
vim.api
    .nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>',
                        opts)
vim.api.nvim_set_keymap('n', '<C-k>',
                        '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>wa',
                        '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>wr',
                        '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
                        opts)
vim.api.nvim_set_keymap('n', '<space>wl',
                        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                        opts)
vim.api.nvim_set_keymap('n', '<space>D',
                        '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>',
                        opts)
vim.api.nvim_set_keymap('n', '<space>ca',
                        '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api
    .nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>e',
                        '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
                        opts)
vim.api.nvim_set_keymap('n', '<leader>[',
                        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>]',
                        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q',
                        '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    " ???  (Text) ", " ???  (Method)", " ???  (Function)",
    " ???  (Constructor)", " ???  (Field)", "[???] (Variable)", " ???  (Class)",
    " ???  (Interface)", " ???  (Module)", " ??? (Property)", " ???  (Unit)",
    " ???  (Value)", " ??? (Enum)", " ???  (Keyword)", " ???  (Snippet)",
    " ???  (Color)", " ???  (File)", " ???  (Reference)", " ???  (Folder)",
    " ???  (EnumMember)", " ???  (Constant)", " ???  (Struct)", " ???  (Event)",
    " ???  (Operator)", " ???  (TypeParameter)"
}

-- General language server
nvim_lsp.efm.setup {
    on_attach = require'completion'.on_attach,
    cmd = {"/usr/bin/efm-langserver"},
    filetypes = {"lua", "vim", "eruby"}
}

-- Typescript language server
nvim_lsp.tsserver.setup {on_attach = require'completion'.on_attach}

-- Ruby language server
nvim_lsp.solargraph.setup {
    on_attach = require'completion'.on_attach,
    filetypes = {"ruby", "rakefile"},
    root_dir = nvim_lsp.util.root_pattern("Gemfile", ".git", "."),
    settings = {
        solargraph = {
            autoformat = true,
            completion = true,
            diagnostic = true,
            folding = true,
            references = true,
            rename = true,
            symbols = true
        }
    }
}

-- Python language server
nvim_lsp.pyright.setup {on_attach = require'completion'.on_attach}

-- CSS language server
nvim_lsp.cssls.setup {on_attach = require'completion'.on_attach}

-- HTML language server
-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
nvim_lsp.html.setup {
    on_attach = require'completion'.on_attach,
    capabilities = capabilities
}

-- JSON language server
nvim_lsp.jsonls.setup {

    commands = {
        Format = {
            function()
                vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
            end
        }
    }
}

-- Rust language server
nvim_lsp.rust_analyzer.setup {on_attach = require'completion'.on_attach}

-- Lua language server
nvim_lsp.sumneko_lua.setup {on_attach = require'completion'.on_attach}

-- TEX language server
-- nvim_lsp.texlab.setup {}

-- Vim language server
nvim_lsp.vimls.setup {on_attach = require'completion'.on_attach}

-- YAML language server
nvim_lsp.yamlls.setup {on_attach = require'completion'.on_attach}

require'lspconfig'.pyls.setup {}
-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
-- local servers = {
--     "efm", "pyright", "rust_analyzer", "tsserver", "solargraph", "cssls",
--     "jsonls", "html", "sumneko_lua", "vimls", "yamlls"
-- }
-- for _, lsp in ipairs(servers) do nvim_lsp[lsp].setup {on_attach = on_attach} end
