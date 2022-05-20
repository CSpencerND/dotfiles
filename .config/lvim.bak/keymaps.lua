lvim.leader = "space"

local normal_mode = {
    ["<TAB>"] = ":bnext<cr>",
    ["<S-TAB>"] = ":bprevious<cr>",
    ["<C-s>"] = ":w<cr>",
    ["<C-q>"] = ":q<cr>",
    ["Y"] = "y$",
    ["<leader>a"] = "ggVG",
    ["<leader>r"] = ":%s/",
    ["<leader>sv"] = ":source ~/.config/lvim/config.lua<CR>",
    ["<C-_>"] = ":set hlsearch!<cr>",
    ["<A-/>"] = ":nohlsearch<cr>"
    -- ["<C-n>"] = ":lua require('material.functions').toggle_style()<cr>",
}

for mapping, command in pairs(normal_mode) do
    lvim.keys.normal_mode[mapping] = command
end

lvim.keys.visual_mode["p"] = [["_dP]]

-- emmet
vim.g.user_emmet_mode = "n"
vim.g.user_emmet_leader_key = ","
