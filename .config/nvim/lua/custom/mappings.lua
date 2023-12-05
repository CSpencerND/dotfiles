---@type MappingsTable
local M = {}

local opts = { noremap = true, silent = true }

M.disabled = {}

M.typescript = {
    n = {
        ["<leader>lo"] = { "<cmd>TSToolsOrganizeImports<cr>", "OrganizeImports" },
        ["<leader>ll"] = { "<cmd>TSToolsSortImports<cr>", "SortImports" },
        ["<leader>lu"] = { "<cmd>TSToolsRemoveUnusedImports<Cr>", "RemoveUnusedImports" },
        ["<leader>lU"] = { "<cmd>TSToolsRemoveUnused<Cr>", "RemoveUnusedSymbols" },
        ["<leader>lm"] = { "<cmd>TSToolsAddMissingImports<Cr>", "AddMissingImports" },
        ["<leader>lf"] = { "<cmd>TSToolsFixAll<Cr>", "FixAllErrors" },
        ["<leader>lg"] = { "<cmd>TSToolsGoToSourceDefinition<Cr>", "GoToSourceDefinition" },
        ["<leader>lr"] = { "<cmd>TSToolsRenameFile<Cr>", "RenameFile" },
        ["<leader>lq"] = { "<cmd>TwoslashQueriesInspect<CR>", "Twoslash Query" },
    },
}

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

        ["<A-Tab>"] = { ":tabnext <CR>", "Tab Next", opts = opts },
        ["<A-S-Tab>"] = { ":tabprevious <CR>", "Tab Previous", opts = opts },

        ["<C-S-l>"] = { ":tabnext <CR>", "Tab Next", opts = opts },
        ["<C-S-h>"] = { ":tabprevious <CR>", "Tab Previous", opts = opts },

        ["<C-.>"] = { ":tabnext <CR>", "Tab Next", opts = opts },
        ["<C-,>"] = { ":tabprevious <CR>", "Tab Previous", opts = opts },

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
        ["<leader>r/"] = { ":%s/", "sed" },
        ["<leader>rs"] = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "super sed" },
        ["<leader>a"] = { "ggVG", "Select All", opts = opts },
        ["gj"] = { "<cmd>TSJJoin<cr>", "join array" },
        ["gk"] = { "<cmd>TSJSplit<cr>", "split array" },
        ["gm"] = { "<cmd>TSJToggle<cr>", "toggle array" },
        ["x"] = { '"_x' },
    },
    v = {
        ["<"] = { "<gv", "Indent Left", opts = opts },
        [">"] = { ">gv", "Indent Right", opts = opts },
        ["p"] = { '"_dP', opts = opts },
        ["x"] = { '"_x', opts = opts },
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

M.general = {
    n = {
        ["<leader>cc"] = { ":e " .. vim.fn.expand "~/.config/nvim/lua/custom/plugins.lua" .. "<CR>" },
        ["<leader>gg"] = { "<cmd> LazyGit <CR>", "Lazy Git" },
        ["<C-q>"] = { ":q <CR>" },
        ["<C-S-q>"] = { ":quitall <CR>" },
        ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Nvimtree" },
        ["<leader>ob"] = { "<cmd> Obsession <CR>", "Obsession" },
        ["<leader>tt"] = {
            function()
                require("base46").toggle_transparency()
            end,
            "Toggle Transparency",
        },
        ["<leader>dd"] = {
            function()
                vim.diagnostic.open_float { border = "rounded" }
            end,
            "Floating Diagnostic",
        },
        ["<leader>tr"] = { "<cmd> TroubleToggle <CR>", "Diagnostics" },
        ["<leader>dT"] = {
            function()
                local vd = vim.diagnostic
                if vd.is_disabled() then
                    vd.enable()
                else
                    vd.disable()
                end
            end,
            "Diagnostic Toggle",
        },
        ["<leader>dt"] = {
            function()
                local config = vim.diagnostic.config

                if config().virtual_text == true then
                    config { virtual_text = false }
                else
                    config { virtual_text = true }
                end
            end,
            "Virtual Text Toggle",
        },
        ["<leader>ok"] = {
            function()
                local iskeyword = vim.opt.iskeyword:get()

                for _, v in ipairs(iskeyword) do
                    if v == "-" then
                        vim.opt.iskeyword:remove "-"
                    else
                        vim.opt.iskeyword:append "-"
                    end
                end
            end,
            "Keyword Hyphen Toggle",
        },
        -- ["<leader>;"] = { ":lua vim.diagnostic.config({virtual_text = false}) <CR>", "Toggle Virtual Text" },
    },
}

-- function ToggleVirtualText()
--     local current_config = vim.diagnostic.get_config({})
--     current_config.virtual_text = not current_config.virtual_text
--     vim.diagnostic.config(current_config)
-- end

vim.api.nvim_set_keymap(
    "n",
    "<leader>;",
    ":lua ToggleVirtualText()<CR>",
    { noremap = true, silent = true, nowait = true }
)
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

M.saga = {
    n = {
        -- ["K"] = { "<cmd> Lspsaga hover_doc <CR>" },
        ["<leader>k"] = { "<cmd> Lspsaga hover_doc ++keep <CR>" },

        ["gd"] = {
            ":execute 'Lspsaga goto_definition' | call timer_start(100, {-> feedkeys('zz')})<CR>",
            "Goto Definition",
        },
        ["gD"] = {
            ":execute 'Lspsaga goto_type_definition' | call timer_start(100, {-> feedkeys('zz')}) <CR>",
            "Goto Type Definition",
        },

        ["<leader>pd"] = { "<cmd> Lspsaga peek_definition <CR>", "Peek Definition" },
        ["<leader>pD"] = { "<cmd> Lspsaga peek_type_definition <CR>", "Peek Type Definition" },

        ["<leader>dD"] = { "<cmd> Lspsaga show_line_diagnostics <CR>", "Diagnostic Current" },
        ["<leader>dj"] = { "<cmd> Lspsaga diagnostic_jump_next <CR>", "Diagnostic Next" },
        ["<leader>dk"] = { "<cmd> Lspsaga diagnostic_jump_prev <CR>", "Diagnostic Previous" },

        ["<leader>dw"] = { "<cmd> Lspsaga show_workspace_diagnostics ++normal <CR>", "Workspace Diagnostics" },
        ["<leader>dW"] = { "<cmd> Lspsaga show_workspace_diagnostics ++float <CR>", "Workspace Diagnostics" },

        ["<leader>sf"] = { "<cmd> Lspsaga finder ++normal <CR>", "Saga Finder" },
        ["<leader>sF"] = { "<cmd> Lspsaga finder ++float <CR>", "Saga Finder" },

        ["<leader>so"] = { "<cmd> Lspsaga outline ++normal <CR>", "Saga Outline" },
        ["<leader>sO"] = { "<cmd> Lspsaga outline ++float <CR>", "Saga Outline" },

        ["<leader>sr"] = { "<cmd> Lspsaga rename <CR>", "Rename" },
        ["<leader>sR"] = { "<cmd> Lspsaga rename ++project <CR>", "Project Rename" },

        ["<leader>sc"] = { "<cmd> Lspsaga outgoing_calls <CR>", "Outgoing Calls" },
        ["<leader>sC"] = { "<cmd> Lspsaga incoming_calls <CR>", "Incoming Calls" },

        ["<leader>da"] = { "<cmd> Lspsaga code_action <CR>", "Diagnostic Actions" },
    },
}

M.package_info = {
    n = {
        ["<leader>Pi"] = { ":lua require('package-info').toggle() <CR>", "Package Info Toggle" },
        ["<leader>Pu"] = { ":lua require('package-info').update() <CR>", "Package Update" },
        ["<leader>Pr"] = { ":lua require('package-info').delete() <CR>", "Package Remove" },
        ["<leader>Pa"] = { ":lua require('package-info').install() <CR>", "Package Add" },
        ["<leader>Pv"] = { ":lua require('package-info').change_version() <CR>", "Package Version" },
    },
}

return M
