require "user.lsp.languages.python"
require "user.lsp.languages.css"
require "user.lsp.languages.html"
require "user.lsp.languages.js-ts"
require "user.lsp.languages.sh"
require "user.lsp.languages.rust"

require("lspconfig").graphql.setup {}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    { command = "stylua", filetypes = { "lua" } },
}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "java",
    "yaml",
}

-- lvim.lsp.on_attach_callback = function(client, bufnr)
-- end

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "eslint_d", filetypes = { "javascript" } },
-- }
