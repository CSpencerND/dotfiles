local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.html.setup {
    capabilities = capabilities,

    filetypes = { "html", "js", "ts", "jsx", "tsx" },

    init_options = {
        configurationSection = {
            "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact"
        },
        embeddedLanguages = {
            css = true,
            javascript = true,
        },
        provideFormatter = false,
    },
}
