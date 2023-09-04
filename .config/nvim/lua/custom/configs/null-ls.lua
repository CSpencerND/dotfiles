local null_ls = require "null-ls"

local format = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {

    -- webdev
    -- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
    -- b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes
    format.prettier,
    lint.eslint_d,

    -- Lua
    format.stylua,

    -- cpp
    format.clang_format,

    -- shell
    format.shfmt,
    lint.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

null_ls.setup {
    debug = true,
    sources = sources,
}
