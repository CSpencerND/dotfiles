vim.g.vscode_snippets_path = "/home/cs/.config/nvim/lua/custom/snippets/"

-- Autocommands ------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
})

local options = {
    timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true, -- enable persistent undo
    updatetime = 100, -- faster completion (4000ms default)
    expandtab = true, -- convert tabs to spaces
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    tabstop = 4, -- insert 2 spaces for a tab
    cursorline = true, -- highlight the current line
    number = true, -- set numbered lines
    relativenumber = true, -- set relative numbered lines
    wrap = false, -- display lines as one long line
    title = true,
    titlestring = "%F - neovim",
    colorcolumn = "96",
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd [[autocmd FileType * set formatoptions-=ro]]
