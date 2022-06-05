local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- Install Plugins
return packer.startup(function(use)
    use { -- Core Components
        "wbthomason/packer.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        "kyazdani42/nvim-tree.lua",
        "akinsho/bufferline.nvim",
        "tamton-aquib/staline.nvim",
        "folke/which-key.nvim",
        "akinsho/toggleterm.nvim",
        "goolord/alpha-nvim",
        "rcarriga/nvim-notify",
        "tversteeg/registers.nvim",
        {
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons" },
        },
    }

    use { -- Completion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-nvim-lua",
        "rcarriga/cmp-dap",
        -- use({
        -- 	"tzachar/cmp-tabnine",
        -- 	config = function()
        -- 		local tabnine = require("cmp_tabnine.config")
        -- 		tabnine:setup({
        -- 			max_lines = 1000,
        -- 			max_num_results = 20,
        -- 			sort = true,
        -- 			run_on_every_keystroke = true,
        -- 			snippet_placeholder = "..",
        -- 			ignored_file_types = {
        -- 				-- default is not to ignore
        -- 				-- uncomment to ignore in lua:
        -- 				-- lua = true
        -- 			},
        -- 		})
        -- 	end,
        --
        -- 	run = "./install.sh",
        -- 	requires = "hrsh7th/nvim-cmp",
        -- }),
    }

    use { -- Snippets
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
    }

    use { -- Language Server
        "neovim/nvim-lspconfig", -- enable LSP
        "williamboman/nvim-lsp-installer", -- simple to use language server installer
        "tamago324/nlsp-settings.nvim", -- language server settings defined in json for formatters and linters
        "jose-elias-alvarez/null-ls.nvim",
        "ray-x/lsp_signature.nvim",
        "nvim-lua/lsp-status.nvim",
    }

    use { -- Treesitter / Syntax Highlighting
        { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
        -- "romgrk/nvim-treesitter-context",
        "JoosepAlviste/nvim-ts-context-commentstring",
        { "p00f/nvim-ts-rainbow" },
        "windwp/nvim-ts-autotag",
        "mizlan/iswap.nvim",
        "nvim-treesitter/playground",
    }

    -------------------------------------------------------------------------------

    use { -- Language specific
        "mlaursen/vim-react-snippets",
        "mattn/emmet-vim",
        "tpope/vim-dadbod",
        -- "kristijanhusak/vim-dadbod-completion",
        "Saecki/crates.nvim",
        "David-Kunz/cmp-npm",
        "b0o/SchemaStore.nvim",
    }

    use { -- Telescope
        "nvim-telescope/telescope.nvim",
        "tom-anders/telescope-vim-bookmarks.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
    }

    use { -- Git Integration
        "lewis6991/gitsigns.nvim",
        "f-person/git-blame.nvim",
        "ruifm/gitlinker.nvim",
        "mattn/vim-gist",
        "mattn/webapi-vim",
        "https://github.com/rhysd/conflict-marker.vim",
    }

    use { -- Debug Adapter Protocol
        "mfussenegger/nvim-dap",
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "Pocco81/DAPInstall.nvim",
    }

    -------------------------------------------------------------------------------

    use { -- Basic Editor Stuff
        "windwp/nvim-autopairs",
        "numToStr/Comment.nvim",
        "lukas-reineke/indent-blankline.nvim",
        "kyazdani42/nvim-web-devicons",
        "norcalli/nvim-colorizer.lua",
        "Mephistophiles/surround.nvim",
        "RRethy/vim-illuminate",
        "windwp/nvim-spectre",
        "filipdutescu/renamer.nvim",
        "simrat39/symbols-outline.nvim",
        "simrat39/symbols-outline.nvim",
        "filipdutescu/renamer.nvim",
        {
            "folke/trouble.nvim",
            cmd = "TroubleToggle",
        },
        {
            "christianchiarulli/nvim-gps",
            branch = "text_hl",
            requires = "nvim-treesitter/nvim-treesitter",
        },
        -- {
        --     "SmiteshP/nvim-gps",
        --     requires = "nvim-treesitter/nvim-treesitter",
        -- },
    }

    use { -- Navigation
        "ahmedkhalf/project.nvim",
        "unblevable/quick-scope",
        "phaazon/hop.nvim",
        "andymass/vim-matchup",
        "ThePrimeagen/harpoon",
        {
            "ghillb/cybu.nvim",
            branch = "v1.x", -- won't receive breaking changes
            -- branch = "main", -- timely updates
            requires = { "kyazdani42/nvim-web-devicons" }, -- optional
        },
    }

    use { -- Vim Perks
        "lewis6991/impatient.nvim",
        "moll/vim-bbye",
        "nacro90/numb.nvim",
        "monaqa/dial.nvim",
        "kevinhwang91/nvim-bqf",
        "tpope/vim-repeat",
        "metakirby5/codi.vim",
        "folke/zen-mode.nvim",
    }

    use { -- Utilities
        "folke/todo-comments.nvim",
        { "michaelb/sniprun", run = "bash ./install.sh" },
        {
            "iamcco/markdown-preview.nvim",
            run = "cd app && npm install",
            ft = "markdown",
        },
    }

    -- Misc
    use "antoinemadec/FixCursorHold.nvim"

    use { -- Colorschemes
        "lunarvim/colorschemes",
        { "dracula/vim", as = "dracula" },
        { "catppuccin/nvim", as = "catppuccin" },
        { "rose-pine/neovim", as = "rose-pine" },
    }
    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
