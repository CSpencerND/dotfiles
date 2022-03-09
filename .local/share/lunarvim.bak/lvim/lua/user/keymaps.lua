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

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
    -- for input mode
    i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev
    },
    -- for normal mode
    n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous
    }
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = {
    "<cmd>Telescope projects<CR>", "Projects"
}

lvim.builtin.which_key.mappings["t"] = {
    name = "+Trouble",
    r = {"<cmd>Trouble lsp_references<cr>", "References"},
    f = {"<cmd>Trouble lsp_definitions<cr>", "Definitions"},
    d = {"<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics"},
    q = {"<cmd>Trouble quickfix<cr>", "QuickFix"},
    l = {"<cmd>Trouble loclist<cr>", "LocationList"},
    w = {"<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics"}
}

lvim.builtin.which_key.mappings["m"] = {
    name = "Harpoon",
    a = {"<cmd>BookmarkAnnotate<cr>", "Annotate"},
    -- b = { "<cmd>lua require('telescope').extensions.vim_bookmarks.current_file({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>", "Show Buffer" },
    c = {"<cmd>BookmarkClear<cr>", "Clear"},
    h = {'<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon Mark"},
    u = {
        '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon Menu"
    },
    m = {"<cmd>BookmarkToggle<cr>", "Toggle"},
    j = {"<cmd>BookmarkNext<cr>", "Next"},
    k = {"<cmd>BookmarkPrev<cr>", "Prev"},
    -- q = { "<cmd>BookmarkShowAll<cr>", "Show QF" },
    s = {
        "<cmd>lua require('telescope').extensions.vim_bookmarks.all({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>",
        "Show All"
    },
    x = {"<cmd>BookmarkClearAll<cr>", "Clear All"}
}
