M = {}
lvim.leader = "space"

local opts = { noremap = true, silent = true }
-- For the description on keymaps, I have a function getOptions(desc) which returns noremap=true, silent=true and desc=desc. Then call: keymap(mode, keymap, command, getOptions("some randome desc")

local keymap = vim.keymap.set

-- Normal --
-- Better window navigation
keymap("n", "<m-h>", "<C-w>h", opts)
keymap("n", "<m-j>", "<C-w>j", opts)
keymap("n", "<m-k>", "<C-w>k", opts)
keymap("n", "<m-l>", "<C-w>l", opts)

-- Scrolling
keymap("n", "<c-j>", "<c-d>", opts)
keymap("n", "<c-k>", "<c-u>", opts)
keymap("n", "<C-e>", "<C-e>j", opts)
keymap("n", "<C-S-y>", "<C-S-y>k", opts)

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

keymap("n", "-", ":lua require'lir.float'.toggle()<cr>", opts)
keymap("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)
keymap("n", "<m-v>", "<cmd>lua require('lsp_lines').toggle()<cr>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- miscellaneous
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<m-Tab>", ":bprevious<CR>", opts)
keymap("n", "<m-i>", ":bnext<CR>", opts)
keymap("n", "<m-u>", ":bprevious<CR>", opts)
keymap("n", "<m-c>", ":bdelete!<CR>", opts)
keymap("n", "<c-s>", ":w<CR>", opts)
keymap("n", "<c-q>", ":q<CR>", opts)
keymap("n", "<c-i>", "<C-i>", opts)
keymap("n", "<m-a>", "ggVG", opts)

keymap("i", "<c-BS>", "<C-w>", opts)
keymap("i", "<c-a>", "<Esc>ea", opts)

function _G.set_terminal_keymaps()
    vim.api.nvim_buf_set_keymap(0, "t", "<m-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<m-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<m-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<m-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

vim.api.nvim_set_keymap(
    "n",
    "<m-P>",
    "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
    -- "<cmd>lua require('telescope').extensions.harpoon.marks(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal', prompt_title='Harpoon'})<cr>",
    opts
)
vim.api.nvim_set_keymap(
    "n",
    "<m-p>",
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal'})<cr>"
    ,
    opts
)

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

keymap("n", "<m-q>", ":call QuickFixToggle()<cr>", opts)

M.show_documentation = function()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("h " .. vim.fn.expand "<cword>")
    elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand "<cword>")
    elseif vim.fn.expand "%:t" == "Cargo.toml" then
        require("crates").show_popup()
    else
        vim.lsp.buf.hover()
    end
end
vim.api.nvim_set_keymap("n", "K", ":lua require('user.keymaps').show_documentation()<CR>", opts)

return M
