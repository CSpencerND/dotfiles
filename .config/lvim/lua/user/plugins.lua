lvim.plugins = {
    "avneesh0612/react-nextjs-snippets",
    "marilari88/twoslash-queries.nvim",
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    {
        "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup {
                width = 120, -- Width of the floating window
                height = 25, -- Height of the floating window
                default_mappings = false, -- Bind default mappings
                debug = false, -- Print debug information
                opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
                post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
                -- You can use "default_mappings = true" setup option
                -- Or explicitly set keybindings
                vim.cmd "nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>",
                vim.cmd "nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
                vim.cmd "nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>",
            }
        end,
    },
    {
        "sindrets/diffview.nvim",
        event = "BufRead",
    },
    {
        "andymass/vim-matchup",
        event = "CursorMoved",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },
    -- {
    --     "echasnovski/mini.map",
    --     branch = "stable",
        -- config = function()
        --     require("mini.map").setup()
        --     local map = require "mini.map"
        --     map.setup {
        --         integrations = {
        --             map.gen_integration.builtin_search(),
        --             map.gen_integration.diagnostic {
        --                 error = "DiagnosticFloatingError",
        --                 warn = "DiagnosticFloatingWarn",
        --                 info = "DiagnosticFloatingInfo",
        --                 hint = "DiagnosticFloatingHint",
        --             },
        --         },
        --         symbols = {
        --             encode = map.gen_encode_symbols.dot "4x2",
        --         },
        --         window = {
        --             side = "right",
        --             width = 20, -- set to 1 for a pure scrollbar :)
        --             winblend = 15,
        --             show_integration_count = false,
        --         },
        --     }
        -- end,
    -- },
    {
        "zbirenbaum/copilot.lua",
        config = function()
            vim.defer_fn(function()
                require("copilot").setup {
                    plugin_manager_path = os.getenv "LUNARVIM_RUNTIME_DIR"
                        .. "/site/pack/packer",
                }
            end, 100)
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup {
                formatters = {
                    insert_text = require("copilot_cmp.format").remove_existing,
                },
            }
        end,
    },
    "jparise/vim-graphql",
    "HiPhish/nvim-ts-rainbow2",
    "jose-elias-alvarez/typescript.nvim",
    "tpope/vim-obsession",
    "NvChad/nvim-colorizer.lua",
    "kylechui/nvim-surround",
    "ThePrimeagen/harpoon",
    "phaazon/hop.nvim",
    "mbbill/undotree",
    "opalmay/vim-smoothie",
    "filipdutescu/renamer.nvim",
    "windwp/nvim-spectre",
    "lvimuser/lsp-inlayhints.nvim",
    "tversteeg/registers.nvim",
    "folke/zen-mode.nvim",

    {
        "Wansmer/treesj",
        requires = { "nvim-treesitter" },
        config = function()
            require("treesj").setup {
                use_default_keymaps = false,
            }
        end,
    },
    {
        "echasnovski/mini.animate",
        config = function()
            require("mini.animate").setup {
                scroll = { enable = false },
            }
        end,
    },

    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },

    {
        "jinh0/eyeliner.nvim",
        config = function()
            require("eyeliner").setup {
                highlight_on_key = true,
            }
        end,
    },

    {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {}
        end,
    },

    {
        "saecki/crates.nvim",
        tag = "v0.3.0",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup {
                null_ls = {
                    enabled = true,
                    name = "crates.nvim",
                },
            }
        end,
    },

    -- colorschemes
    "rebelot/kanagawa.nvim",
    "lunarvim/horizon.nvim",
    "lunarvim/darkplus.nvim",
    "lunarvim/templeos.nvim",
}
