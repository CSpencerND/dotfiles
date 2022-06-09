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
----------------------

require "user.catppuccin"
require "user.rose-pine"
require "user.quickscope"

require "user.alpha"
require "user.autocommands"
require "user.autopairs"
require "user.bookmark"
require "user.bufferline"
require "user.colorizer"
require "user.comment"
require "user.dial"
require "user.git-blame"
require "user.hop"
require "user.illuminate"
require "user.indentline"
require "user.matchup"
require "user.notify"
require "user.numb"
require "user.nvim-tree"
require "user.registers"
require "user.renamer"
require "user.spectre"
require "user.surround"
require "user.telescope"
require "user.todo-comments"
require "user.toggleterm"
-- require "user.ts-context"
require "user.zen-mode"
require "user.winbar"
require "user.gps"

-- Colorscheme
-- vim.cmd([[set background=light]])
vim.cmd([[
    try
        " idk why rose-pine doesn't work properly unless I call it after another
        colorscheme catppuccin "<-- here!
        " colorscheme onedarkest "<-- here!
        " colorscheme rose-pine "<-- here!
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default
        set background=dark
    endtry
]])

vim.cmd([[hi DiagnosticError guibg=NONE]])
vim.cmd([[hi DiagnosticInfo guibg=NONE]])
vim.cmd([[hi DiagnosticHint guibg=NONE]])
vim.cmd([[hi DiagnosticWarn guibg=NONE]])

