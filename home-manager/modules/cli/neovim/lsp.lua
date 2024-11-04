local on_attach = function(_, bufnr)
    local bufmap = function(keys, func)
        vim.keymap.set('n', keys, func, { buffer = bufnr })
    end

    bufmap('<leader>r', vim.lsp.buf.rename)
    bufmap('<leader>a', vim.lsp.buf.code_action)
    bufmap('<leader>e', function() vim.diagnostic.open_float({scope="line"}) end)

    bufmap('<leader>i', vim.lsp.buf.implementation)
    bufmap('<leader>d', vim.lsp.buf.definition)
    bufmap('<leader>D', vim.lsp.buf.declaration)
    bufmap('<leader>n', vim.diagnostic.goto_next)
    bufmap('<leader>N', vim.diagnostic.goto_prev)

    --bufmap('gr', require('telescope.builtin').lsp_references)
    --bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
    --bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

    bufmap('K', vim.lsp.buf.hover)

    vim.highlight.priorities.semantic_tokens = 95 

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup {
     on_attach = on_attach,
     capabilities = capabilities,
     Lua = {
       workspace = { checkThirdParty = false },
       telemetry = { enable = false },
     },
}
lspconfig.ccls.setup {
     on_attach = on_attach,
     capabilities = capabilities,
}
lspconfig.nil_ls.setup {
     on_attach = on_attach,
     capabilities = capabilities,
}
lspconfig.rust_analyzer.setup {
     on_attach = on_attach,
     capabilities = capabilities,
}
lspconfig.gopls.setup {
     on_attach = on_attach,
     capabilities = capabilities,
}
