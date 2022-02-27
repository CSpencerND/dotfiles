--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]] -- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "dracula"
lvim.lsp.diagnostics.virtual_text = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<TAB>"] = ":bnext<cr>"
lvim.keys.normal_mode["<S-TAB>"] = ":bprevious<cr>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
lvim.keys.normal_mode["Y"] = "y$"
lvim.keys.normal_mode["<C-n>"] =
    ":lua require('material.functions').toggle_style()<cr>"
lvim.keys.normal_mode["<leader>a"] = "ggVG"
lvim.keys.normal_mode["<leader>r"] = ":%s/"
lvim.keys.normal_mode["<leader>sv"] = ":source ~/.config/lvim/config.lua<CR>"
-- lvim.keys.normal_mode["<C-S-o"] = "<C-i>"
lvim.keys.visual_mode["p"] = [["_dP]]
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

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

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.bufferline.active = true
lvim.builtin.bufferline.options = {always_show_bufferline = true}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash", "c", "javascript", "json", "lua", "python", "typescript", "tsx",
    "css", "rust", "java", "yaml"
}

lvim.builtin.treesitter.ignore_install = {"haskell"}
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        command = "lua-format", filetypes = {"lua"}
    },
    {
        command = "rustfmt", filetypes = {"rust"}
    },
    {
        command = "black",
        args = {"--target-version", "py310"},
        filetypes = {"python"}
    },
    {
        command = "prettier",
        filetypes = {
            "typescript", "typescriptreact", "javascript", "javascriptreact",
            "json", "css", "html"
        }
    }
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {command = "flake8", filetypes = {"python"}}, {
        -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
        command = "shellcheck",
        ---@usage arguments to pass to the formatter
        -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
        extra_args = {"--severity", "warning"}
    }, {
        command = "codespell",
        ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
        filetypes = {"javascript", "python"}
    }
}

-- Additional Plugins
lvim.plugins = {
    {"artanikin/vim-synthwave84"}, {"cofyc/vim-uncrustify"}, {"psf/black"},
    {"dracula/vim"}, {"lunarvim/colorschemes"}, {"romgrk/doom-one.vim"},
    -- { "morhetz/gruvbox" },
    -- { "folke/tokyonight.nvim" },
    -- { "arzg/vim-substrata" },
    -- { "kyazdani42/nvim-palenight.lua" },
    -- { "marko-cerovac/material.nvim" },
    {"zeekay/vim-beautify"}, {"mattn/emmet-vim"},
    {"mtdl9/vim-log-highlighting"}, {"ckipp01/stylua-nvim"},
    {"sindrets/diffview.nvim", event = "BufRead"}, {
        "turbio/bracey.vim",
        cmd = {"Bracey", "BracyStop", "BraceyReload", "BraceyEval"},
        run = "npm install --prefix server"
    }, {
        "norcalli/nvim-colorizer.lua",
        config = function() require("user.colorizer").config() end
    }, -- {
    --   "lukas-reineke/indent-blankline.nvim",
    --   event = "BufReadPre",
    --   config = function()
    --     require "user.blankline"
    --   end
    -- },
    {
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
    }, {"tpope/vim-surround"}
    -- {
    --   "simrat39/symbols-outline.nvim",
    --   cmd = "SymbolsOutline",
    -- },
    -- {
    --   "unblevable/quick-scope",
    --   config = function()
    --     require "user.quickscope"
    --   end,
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
    --   "folke/todo-comments.nvim",
    --   event = "BufRead",
    -- },
    -- {
    --   "lewis6991/spellsitter.nvim",
    --   config = function()
    --     require('spellsitter').setup()
    --   end
    -- },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

vim.opt.tabstop = 8
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.linebreak = true
-- vim.opt.wrap = true
vim.opt.hidden = true
vim.opt.colorcolumn = "80"
