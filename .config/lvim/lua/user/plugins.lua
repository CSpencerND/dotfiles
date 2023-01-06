lvim.plugins = {
    "mrjones2014/nvim-ts-rainbow",
    "jose-elias-alvarez/typescript.nvim",
    "tpope/vim-obsession",
    "p00f/nvim-ts-rainbow",
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

    { "tzachar/cmp-tabnine", run = "./install.sh" },

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

    -- "folke/todo-comments.nvim",
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
