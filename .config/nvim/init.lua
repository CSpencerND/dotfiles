-- Core
require "user.plugins"
require "user.cmp"
require "user.lsp"
require "user.treesitter"
require "user.keymaps"
require "user.whichkey"
require "user.options"
require "user.gitsigns"
require "user.lualine"
require "user.functions"
------------------------

-- require "user.catppuccin"
-- require "user.rose-pine"
require "user.quickscope"
require "user.alpha"
require "user.autocommands"
require "user.autopairs"
require "user.bufferline"
require "user.colorizer"
require "user.comment"
require "user.dap"
require "user.dial"
require "user.fidget"
require "user.git-blame"
require "user.hop"
require "user.illuminate"
require "user.indentline"
require "user.jaq"
require "user.matchup"
require "user.notify"
require "user.numb"
require "user.nvim-tree"
require "user.project"
require "user.registers"
require "user.renamer"
require "user.spectre"
require "user.surround"
require "user.telescope"
require "user.todo-comments"
require "user.toggleterm"
require "user.zen-mode"
require "user.winbar"
require "user.gps"
-- require "user.inlay-hints"

-- [[ require "user.bookmark" ]]
-- require("mason").setup()
-- require "user.ts-context"
-- require "user.lsp-inlayhints"

-- Colorscheme
--[[ vim.o.background = "light" ]]
-- vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
-- vim.g.sonokai_style = "andromeda"
-- vim.g.gruvbox_contrast_dark = "medium"

vim.cmd([[
    try
        " colorscheme catppuccin
        " colorscheme horizon
        " colorscheme tokyonight-night
        colorscheme kanagawa
        " colorscheme rose-pine
        " colorscheme gruvbox
        " colorscheme synthwave84
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default
        set background=dark
    endtry
]])

vim.cmd([[hi DiagnosticError guibg=NONE]])
vim.cmd([[hi DiagnosticInfo guibg=NONE]])
vim.cmd([[hi DiagnosticHint guibg=NONE]])
vim.cmd([[hi DiagnosticWarn guibg=NONE]])
