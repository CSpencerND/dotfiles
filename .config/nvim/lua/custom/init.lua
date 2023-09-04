vim.g.vscode_snippets_path = "/home/cs/.config/nvim/lua/custom/snippets/"

-- Autocommands ------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
})

-- local function open_nvim_tree(data)
--     local real_file = vim.fn.filereadable(data.file) == 1
--     local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
--
--     if not real_file and not no_name then
--         require("nvim-tree.api").tree.toggle { focus = true, find_file = true }
--     end
-- end

-- autocmd({ "VimEnter" }, { callback = open_nvim_tree })

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

require("custom.configs.lspsaga")
