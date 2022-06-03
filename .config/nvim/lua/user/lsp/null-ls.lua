local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
    debug = false,
    sources = {
        -- formatting
        formatting.stylua,
        formatting.rustfmt,
        formatting.prettier.with { extra_args = { "--no-semi" } },
        formatting.black, -- .with({ extra_args = { "--fast" } }),
        formatting.shfmt,
        formatting.codespell.with { filetypes = { "markdown", "txt" } },

        -- diagnostics
        diagnostics.flake8,
        diagnostics.shellcheck,
    },
}
