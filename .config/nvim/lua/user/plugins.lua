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
    autocmd BufWritePost plugins.lua source <afile> | PackerInstall
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
        "tpope/vim-obsession",
        "wbthomason/packer.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        "kyazdani42/nvim-tree.lua",
        "akinsho/bufferline.nvim",
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
        -- "hrsh7th/cmp-nvim-lsp",
        {
            "hrsh7th/cmp-nvim-lsp",
            commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8",
        },
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-emoji",
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
        "rafamadriz/friendly-snippets",
        "L3MON4D3/LuaSnip",
    }

    use { -- Language Server
        -- "neovim/nvim-lspconfig", -- enable LSP
        {
            "neovim/nvim-lspconfig",
            commit = "148c99bd09b44cf3605151a06869f6b4d4c24455",
        },
        -- "williamboman/nvim-lsp-installer", -- simple to use language server installer
        {
            "williamboman/nvim-lsp-installer",
            commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6",
        },
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "tamago324/nlsp-settings.nvim", -- language server settings defined in json for formatters and linters
        {
            "jose-elias-alvarez/null-ls.nvim",
            --[[ commit = "ff40739e5be6581899b43385997e39eecdbf9465", ]]
        },
        "ray-x/lsp_signature.nvim",
        -- {
        --     "ray-x/lsp_signature.nvim",
        --     commit = "4852d99f9511d090745d3cc1f09a75772b9e07e9",
        -- },
        "nvim-lua/lsp-status.nvim",
        {
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            config = function()
                require("lsp_lines").setup()
            end,
        },
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
        {
            "dsznajder/vscode-es7-javascript-react-snippets",
            run = "yarn install --frozen-lockfile && yarn compile",
        },
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
        "ravenxrz/DAPInstall.nvim",
        -- "Pocco81/dap-buddy.nvim",
    }

    -------------------------------------------------------------------------------

    use { -- Basic Editor Stuff
        "mg979/vim-visual-multi",
        "windwp/nvim-autopairs",
        "numToStr/Comment.nvim",
        "lukas-reineke/indent-blankline.nvim",
        "kyazdani42/nvim-web-devicons",
        "norcalli/nvim-colorizer.lua",
        "Mephistophiles/surround.nvim",
        "RRethy/vim-illuminate",
        "windwp/nvim-spectre",
        "simrat39/symbols-outline.nvim",
        {
            "filipdutescu/renamer.nvim",
            branch = "master",
            requires = { { "nvim-lua/plenary.nvim" } },
        },
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
        "is0n/jaq-nvim",
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
        "MattesGroeger/vim-bookmarks",
    }

    use { -- Nvim Perks
        "lewis6991/impatient.nvim",
        "moll/vim-bbye",
        "nacro90/numb.nvim",
        "monaqa/dial.nvim",
        "kevinhwang91/nvim-bqf",
        "tpope/vim-repeat",
        "metakirby5/codi.vim",
        "folke/zen-mode.nvim",
        "Djancyp/cheat-sheet",
        "lvimuser/lsp-inlayhints.nvim",
        {
            "declancm/cinnamon.nvim",
            config = function()
                require("cinnamon").setup()
            end,
        },
        "j-hui/fidget.nvim",
        "mbbill/undotree",
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
        "sainnhe/sonokai",
        "lunarvim/horizon.nvim",
        "lunarvim/synthwave84.nvim",
        "morhetz/gruvbox",
        "folke/tokyonight.nvim",
        "rebelot/kanagawa.nvim",
    }
    use { "shaunsingh/oxocarbon.nvim", branch = "fennel" }

    -- Automatically set up your configuration after cloning packer.nvim
    -- if PACKER_BOOTSTRAP then
    --     require("packer").sync()
    -- end
end)
