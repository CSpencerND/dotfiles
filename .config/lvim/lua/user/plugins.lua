lvim.plugins = {
    -- { "echasnovski/mini.nvim", branch = "stable" },
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
    "mrjones2014/nvim-ts-rainbow",
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
    "petertriho/nvim-scrollbar",
    "lvimuser/lsp-inlayhints.nvim",
    "tversteeg/registers.nvim",
    "folke/zen-mode.nvim",

    "renerocksai/telekasten.nvim",
    "renerocksai/calendar-vim",

    -- { "tzachar/cmp-tabnine", run = "./install.sh" },
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
