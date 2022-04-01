-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "dracula"
lvim.lsp.diagnostics.virtual_text = false

lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.bufferline.active = true
lvim.builtin.bufferline.options = {always_show_bufferline = true}

-- vim.g.bracey_browser_command = "brave"

require "user.keymaps"
require "user.bufferline"
require "user.plugins"

require("telescope").load_extension('harpoon')

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash", "c", "javascript", "json", "lua", "python", "typescript", "tsx",
    "css", "rust", "java", "yaml"
}

lvim.builtin.treesitter.ignore_install = {"haskell"}
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {command = "lua-format", filetypes = {"lua"}},
    {command = "rustfmt", filetypes = {"rust"}}, {
        command = "black",
        args = {"--target-version", "py310"},
        filetypes = {"python"}
    }, {
        command = "prettier",
        filetypes = {
            "typescript", "typescriptreact", "javascript", "javascriptreact",
            "json", "css", "less", "scss", "html", "markdown"
        }
    } -- {command = "codespell"},
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {command = "flake8", filetypes = {"python"}}, {
        -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
        command = "shellcheck",
        ---@usage arguments to pass to the formatter
        -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
        extra_args = {"--severity", "warning"}
    }, {
        command = "codespell",
        ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
        filetypes = {"javascript", "python"}
    }
}

vim.opt.tabstop = 8
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.linebreak = true
-- vim.opt.wrap = true
vim.opt.hidden = true
vim.opt.colorcolumn = "80"
