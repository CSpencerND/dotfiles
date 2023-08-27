---@type MappingsTable
local M = {}

local opts = { noremap = true, silent = true }

M.disabled = {}

M.tabufline = {
    n = {
        ["<C-i>"] = {
            function()
                require("nvchad.tabufline").tabuflineNext()
            end,
            "Buffer Next",
        },

        ["<C-u>"] = {
            function()
                require("nvchad.tabufline").tabuflinePrev()
            end,
            "Buffer Previous",
        },

        ["<C-S-i>"] = {
            function()
                require("nvchad.tabufline").move_buf(1)
            end,
            "Move Buffer Next",
        },

        ["<C-S-u>"] = {
            function()
                require("nvchad.tabufline").move_buf(-1)
            end,
            "Move Buffer Previous",
        },

        ["<A-Tab>"] = { "<cmd> Telescope buffers <CR>", "List Buffers", opts = opts },

        ["<C-S-l>"] = { ":tabnext <CR>", "Tab Next", opts = opts },
        ["<C-S-h>"] = { ":tabprevious <CR>", "Tab Previous", opts = opts },

        ["<leader>ti"] = { ":tabnext <CR>", "Tab Next", opts = opts },
        ["<leader>tu"] = { ":tabprevious <CR>", "Tab Previous", opts = opts },

        ["<leader>tn"] = { ":tabnew <CR>", "Tab New", opts = opts },
        ["<leader>tx"] = { ":tabclose <CR>", "Tab Close", opts = opts },
    },
}

M.movement = {
    n = {
        ["<C-j>"] = { "<cmd> call smoothie#do('<C-d>zz') <CR>", "Half Page Down", opts = opts },
        ["<C-k>"] = { "<cmd> call smoothie#do('<C-u>zz') <CR>", "Half Page Up", opts = opts },
        ["<A-j>"] = { "<C-e>jzz", "One Line Down", opts = opts },
        ["<A-k>"] = { "<C-Y>kzz", "One Line Up", opts = opts },
        ["n"] = { "nzz", opts = opts },
        ["N"] = { "Nzz", opts = opts },
        ["*"] = { "*zz", opts = opts },
        ["g*"] = { "g*zz", opts = opts },

        ["<C-b>"] = { "<Home>", "Beginning of line" },
        ["<C-e>"] = { "<End>", "End of line" },
        ["<C-l>"] = { "<C-w>w", "Cycle Windows" },
    },

    i = {
        ["<C-b>"] = { "<Home>", "Beginning of line" },
        ["<C-e>"] = { "<End>", "End of line" },
    },

    x = {
        ["<C-b>"] = { "<Home>", "Beginning of line" },
        ["<C-e>"] = { "<End>", "End of line" },
        ["<C-j>"] = { "<cmd> call smoothie#do('<C-d>zz') <CR>", "Half Page Down", opts = opts },
        ["<C-k>"] = { "<cmd> call smoothie#do('<C-u>zz') <CR>", "Half Page Up", opts = opts },
    },
}

M.editing = {
    n = {
        ["<leader>k"] = { "<cmd>TwoslashQueriesInspect<CR>", "Twoslash Query" },
        ["<leader>r/"] = { ":%s/", "sed" },
        ["<leader>rs"] = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "super sed" },
        ["<leader>a"] = { "ggVG", "Select All", opts = opts },
        ["gj"] = { "<cmd>TSJJoin<cr>", "join array" },
        ["gk"] = { "<cmd>TSJSplit<cr>", "split array" },
        ["gm"] = { "<cmd>TSJToggle<cr>", "toggle array" },
    },
    v = {
        ["<"] = { "<gv", "Indent Left", opts = opts },
        [">"] = { ">gv", "Indent Right", opts = opts },
        ["p"] = { '"_dP', opts = opts },
    },
    x = {
        ["J"] = { ":move '>+1<CR>gv-gv", opts = opts },
        ["K"] = { ":move '<-2<CR>gv-gv", opts = opts },
    },
}

local m = "<leader>m"

M.harpoon = {
    n = {
        [m .. "g"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon GUI" },
        [m .. "m"] = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon Mark" },

        [m .. "n"] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" },
        [m .. "p"] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" },

        [m .. "/"] = { "<cmd>Telescope harpoon marks<cr>", "Harpoon Search" },

        [m .. "a"] = { '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', "Harpoon 1" },
        [m .. "s"] = { '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', "Harpoon 2" },
        [m .. "d"] = { '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', "Harpoon 3" },
        [m .. "f"] = { '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', "Harpoon 4" },
        [m .. "q"] = { '<cmd>lua require("harpoon.ui").nav_file(5)<cr>', "Harpoon 5" },
        [m .. "w"] = { '<cmd>lua require("harpoon.ui").nav_file(6)<cr>', "Harpoon 6" },
        [m .. "e"] = { '<cmd>lua require("harpoon.ui").nav_file(7)<cr>', "Harpoon 7" },
        [m .. "r"] = { '<cmd>lua require("harpoon.ui").nav_file(8)<cr>', "Harpoon 8" },
    },
}

M.options = {
    n = {
        ["<leader>on"] = { "<cmd> set nu! <CR>", "Line Numbers" },
        ["<leader>or"] = { "<cmd> set rnu! <CR>", "Relative Numbers" },
        ["<leader>ol"] = { "<cmd> set cursorline! <CR>", "Cursorline" },
        ["<leader>ow"] = { "<cmd> set wrap! <CR>", "Wrap" },
    },
}

M.misc = {
    n = {
        ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Info" },
        ["<C-q>"] = { ":q <CR>" },
        ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Nvimtree" },
        ["<leader>ob"] = { "<cmd> Obsession <CR>", "Obsession" },
        ["<leader>tt"] = {
            function()
                require("base46").toggle_transparency()
            end,
            "Toggle Transparency",
        },
        ["<leader>fd"] = {
            function()
                vim.diagnostic.open_float { border = "rounded" }
            end,
            "Floating Diagnostic",
        },
        ["<leader>tr"] = { "<cmd> TroubleToggle <CR>", "Diagnostics" },
    },
}

M.hop = {
    n = {
        [";"] = { ":HopWord<cr>", opts = opts },
        ["<C-;>"] = { ":HopWordCurrentLine<cr>", opts = opts },
        ["f"] = {
            ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<CR>",
            opts = opts,
        },
        ["F"] = {
            ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<CR>",
            opts = opts,
        },
        ["t"] = {
            ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = false })<CR>",
            opts = opts,
        },
        ["T"] = {
            ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = false })<CR>",
            opts = opts,
        },
    },
}

return M
