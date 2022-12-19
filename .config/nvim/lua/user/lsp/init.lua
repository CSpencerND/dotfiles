local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require "user.lsp.configs"
require("user.lsp.handlers").setup()
require "user.lsp.lsp-installer"
-- require "user.lsp.mason"
require "user.lsp.lsp-signature"
require "user.lsp.null-ls"

local l_status_ok, lsp_lines = pcall(require, "lsp_lines")
if not l_status_ok then
    return
end

lsp_lines.setup()
