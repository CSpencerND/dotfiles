-- Additional Plugins
lvim.plugins = {
    {"ThePrimeagen/harpoon"}, {"artanikin/vim-synthwave84"},
    {"cofyc/vim-uncrustify"}, {"psf/black"}, {"dracula/vim"},
    {"lunarvim/colorschemes"}, {"romgrk/doom-one.vim"}, {"zeekay/vim-beautify"},
    {"mattn/emmet-vim"}, {"mtdl9/vim-log-highlighting"},
    {"ckipp01/stylua-nvim"}, {"sindrets/diffview.nvim", event = "BufRead"}, {
        "turbio/bracey.vim",
        cmd = {"Bracey", "BracyStop", "BraceyReload", "BraceyEval"},
        run = "npm install --prefix server"
    }, {
        "norcalli/nvim-colorizer.lua",
        config = function() require("user.colorizer").config() end
    }, {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        setup = function()
            vim.g.indentLine_enabled = 1
            vim.g.indent_blankline_char = "▏"
            vim.g.indent_blankline_filetype_exclude = {
                "help", "terminal", "dashboard"
            }
            vim.g.indent_blankline_buftype_exclude = {"terminal"}
            vim.g.indent_blankline_show_trailing_blankline_indent = false
            vim.g.indent_blankline_show_first_indent_level = true
        end
    }, {
        "karb94/neoscroll.nvim",
        config = function() require("user.neoscroll").config() end
    }, {"tpope/vim-surround"},
    {
        "unblevable/quick-scope",
        config = function() require "user.quickscope" end
    }
    -- {
    --   "simrat39/symbols-outline.nvim",
    --   cmd = "SymbolsOutline",
    -- },
    -- {
    --   "folke/trouble.nvim",
    --   cmd = "TroubleToggle"
    -- },
    -- {
    --   "nvim-treesitter/playground",
    --   event = "BufRead",
    -- },
    -- {
    --   "phaazon/hop.nvim",
    --   event = "BufRead",
    --   config = function()
    --     require("user.hop").config()
    --   end,
    -- },
    -- {
    --   "nacro90/numb.nvim",
    --   event = "BufRead",
    --   config = function()
    --     require("user.numb").config()
    --   end,
    -- },
    -- {
    --   "rcarriga/nvim-notify",
    --   event = "BufRead",
    --   config = function()
    --     require("user.notify").config()
    --   end,
    -- },
    -- {
    --   "vuki656/package-info.nvim",
    --   config = function()
    --     require "user.package-info"
    --   end,
    --   ft = "json",
    -- },
    -- {
    --   "lewis6991/spellsitter.nvim",
    --   config = function()
    --     require('spellsitter').setup()
    --   end
    -- },
}
