local nvim_lsp = require("lspconfig")

local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
local opts = {noremap = true, silent = true}
buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', '<space>wa',
               '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wr',
               '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wl',
               '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
               opts)
buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>',
               opts)
buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', '<space>e',
               '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
buf_set_keymap('n', '<leader>[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
               opts)
buf_set_keymap('n', '<leader>]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
               opts)
buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',
               opts)

-- General language server
nvim_lsp.efm.setup {}

-- Typescript language server
nvim_lsp.tsserver.setup {}

-- Ruby language server
nvim_lsp.solargraph.setup {
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
nvim_lsp.pyright.setup {}

-- CSS language server
nvim_lsp.cssls.setup {}

-- HTML language server
-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
nvim_lsp.html.setup {capabilities = capabilities}

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
nvim_lsp.rust_analyzer.setup {}

-- Lua language server
nvim_lsp.sumneko_lua.setup {}

-- TEX language server
-- nvim_lsp.texlab.setup {}

-- Vim language server
nvim_lsp.vimls.setup {}

-- YAML language server
nvim_lsp.yamlls.setup {}

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
-- local servers = {
--     "efm", "pyright", "rust_analyzer", "tsserver", "solargraph", "cssls",
--     "jsonls", "html", "sumneko_lua", "vimls", "yamlls"
-- }
-- for _, lsp in ipairs(servers) do nvim_lsp[lsp].setup {on_attach = on_attach} end
