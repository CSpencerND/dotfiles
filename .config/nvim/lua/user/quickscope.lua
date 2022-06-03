-- vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
-- vim.g.qs_lazy_highlight = 1

vim.cmd [[
    augroup qs_colors
      autocmd!
      autocmd ColorScheme * highlight QuickScopePrimary guifg='#f892df' ctermfg=155 cterm=underline "gui=underline
      autocmd ColorScheme * highlight QuickScopeSecondary guifg='#f28f9d' ctermfg=81 cterm=underline "gui=underline
    augroup END
]]

