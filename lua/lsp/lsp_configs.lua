local nvim_lsp = require("lspconfig")
-- General language server
nvim_lsp.efm.setup {}

-- Typescript language server
nvim_lsp.tsserver.setup {}

-- Ruby language server
nvim_lsp.solargraph.setup {}

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
