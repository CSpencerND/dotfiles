local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "tailwindcss", "prismals", "jsonls", "clangd" }

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

lspconfig.tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.prismals.setup {}

lspconfig.cssls.setup {
    capabilities = capabilities,
    settings = {
        css = {
            lint = {
                unknownAtRules = "ignore",
            },
        },
    },
}

lspconfig.tailwindcss.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require("typescript").setup {
    -- disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
    },
    server = {
        on_attach = function(client, bufnr)
            require("twoslash-queries").attach(client, bufnr)
        end,

        capabilities = capabilities,
    },
}