vim.g.vscode_snippets_path = "/home/cs/.config/nvim/lua/custom/snippets/"

-- Autocommands ------------------------------
local autocmd = vim.api.nvim_create_autocmd

autocmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
    desc = "Auto resize panes when resizing nvim window",
})

autocmd("BufEnter", {
    pattern = ".env*",
    group = vim.api.nvim_create_augroup("__env", { clear = true }),
    callback = function(args)
        vim.diagnostic.disable(args.buf)
    end,
    desc = "Exempt env files from lsp",
})

autocmd("FileType", {
    command = "set formatoptions-=cro",
    desc = "Disable New Line Comment",
})

autocmd("FileType", {
    command = "set iskeyword+=-",
    desc = "Add hyphen to keyword detection",
})

local opt = vim.opt

opt.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile = true -- enable persistent undo
opt.updatetime = 100 -- faster completion (4000ms default)
opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
opt.tabstop = 4 -- insert 2 spaces for a tab
opt.cursorline = true -- highlight the current line
opt.number = true -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.wrap = false -- display lines as one long line
opt.title = true
opt.titlestring = "%F - neovim"
opt.colorcolumn = "82"
