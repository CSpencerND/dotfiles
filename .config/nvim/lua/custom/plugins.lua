local overrides = require("custom.configs.overrides")
local home = vim.fn.expand("$HOME")

---@type NvPluginSpec[]
local plugins = {

    -- Override plugin definition options

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- format & linting
            {
                "nvimtools/none-ls.nvim",
                event = "VeryLazy",
                opts = function()
                    return require("custom.configs.null-ls")
                end,
            },
        },
        config = function()
            require("plugins.configs.lspconfig")
            require("custom.configs.lspconfig")
            require("mason-lspconfig").setup()

            vim.diagnostic.config({
                virtual_text = false,
            })
        end, -- Override to setup mason-lspconfig
    },

    -------------------------------------------------------------------------------------------
    -- override plugin configs ----------------------------------------------------------------
    {
        "numToStr/Comment.nvim",
        opts = function()
            return {
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            }
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        opts = overrides.telescope,
    },
    {
        "hrsh7th/nvim-cmp",
        opts = overrides.cmp,
    },
    {
        "williamboman/mason.nvim",
        opts = overrides.mason,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            {
                "windwp/nvim-ts-autotag",
                ft = {
                    "html",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                },
                config = function()
                    require("nvim-ts-autotag").setup()
                    -- require("ts_context_commentstring").setup({
                    --     enable_autocmd = false,
                    --     languages = {
                    --         typescript = "// %s",
                    --         css = "/* %s */",
                    --         scss = "/* %s */",
                    --         html = "<!-- %s -->",
                    --         svelte = "<!-- %s -->",
                    --         vue = "<!-- %s -->",
                    --         json = "",
                    --     },
                    -- })
                end,
            },
        },
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = overrides.nvimtree,
    },
    {
        "NvChad/nvim-colorizer.lua",
        opts = overrides.colorizer,
    },

    -------------------------------------------------------------------------------------------
    -- Install a plugin -----------------------------------------------------------------------
    {
        "rcarriga/nvim-notify",
        lazy = false,
        config = function()
            vim.notify = require("notify")
            require("telescope").load_extension("notify")
        end,
        enabled = false,
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
    },
    {
        "davidosomething/format-ts-errors.nvim",
    },
    {
        "vuki656/package-info.nvim",
        ft = "json",
        dependencies = { "MunifTanjim/nui.nvim" },
        config = function()
            local colors = require("base46.themes.catppuccin").base_16

            require("package-info").setup({
                package_manager = "pnpm",
                hide_up_to_date = false,
                hide_unstable_versions = false,
                colors = {
                    outdated = colors.base0C,
                    up_to_date = colors.base03,
                },
                icons = {
                    enable = true,
                    style = {
                        up_to_date = "|  ",
                        outdated = "|  ",
                    },
                },
            })

            require("telescope").load_extension("package_info")
        end,
    },
    {
        "uga-rosa/ccc.nvim",
        event = "VeryLazy",
        config = function()
            local ccc = require("ccc")
            ccc.setup({
                inputs = {
                    ccc.input.hsl,
                    ccc.input.rgb,
                    ccc.input.hex,
                },
            })
        end,
    },
    {
        "js-everts/cmp-tailwind-colors",
        event = "VeryLazy",
    },
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
            require("chatgpt").setup({
                api_key_cmd = "gpg --decrypt " .. home .. "/.gpt.gpg",
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        enabled = false,
    },
    {
        "nvimdev/lspsaga.nvim",
        config = function()
            require("lspsaga").setup({})
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        event = "LspAttach",
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "LspAttach",
    },
    {
        "mlaursen/vim-react-snippets",
        event = "VeryLazy",
    },
    {
        "hrsh7th/nvim-cmp",
        event = "VeryLazy",
    },
    {
        "hrsh7th/cmp-cmdline",
        event = "VeryLazy",
    },
    -- {
    --     "jose-elias-alvarez/typescript.nvim",
    --     event = "VeryLazy",
    -- },
    {
        "kdheepak/lazygit.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "Wansmer/treesj",
        event = "VeryLazy",
        requires = { "nvim-treesitter" },
        config = function()
            require("treesj").setup({
                use_default_keymaps = false,
            })
        end,
    },
    {
        "andymass/vim-matchup",
        event = "CursorMoved",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    {
        "prisma/vim-prisma",
        event = "VeryLazy",
    },
    {
        "avneesh0612/react-nextjs-snippets",
        event = "VeryLazy",
    },
    {
        "marilari88/twoslash-queries.nvim",
        event = "VeryLazy",
        enabled = false,
    },
    {
        "tpope/vim-obsession",
        event = "VeryLazy",
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                keymaps = { -- vim-surround style keymaps
                    normal = "s",
                    visual = "s",
                    delete = "ds",
                    change = "cs",
                    insert = nil,
                    insert_line = nil,
                    normal_cur = nil,
                    normal_line = nil,
                    normal_cur_line = nil,
                    visual_line = nil,
                },
            })
        end,
    },
    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
    },
    {
        "phaazon/hop.nvim",
        event = "VeryLazy",
        branch = "v2", -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
        end,
    },
    {
        "opalmay/vim-smoothie",
        event = "VeryLazy",
    },
    {
        "tversteeg/registers.nvim",
        event = "VeryLazy",
    },
    {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
    },
    {
        "fladson/vim-kitty",
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.animate",
        event = "VeryLazy",
        config = function()
            require("mini.animate").setup({
                scroll = { enable = false },
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup({})
        end,
    },
    --     "zbirenbaum/copilot.lua",
    --     config = function()
    --         vim.defer_fn(function()
    --             require("copilot").setup {
    --                 plugin_manager_path = os.getenv "LUNARVIM_RUNTIME_DIR"
    --                     .. "/site/pack/packer",
    --             }
    --         end, 100)
    --     end,
    -- lazy = true,
    -- },
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     after = { "copilot.lua" },
    --     config = function()
    --         require("copilot_cmp").setup {
    --             formatters = {
    --                 insert_text = require("copilot_cmp.format").remove_existing,
    --             },
    --         }
    --     end,
    -- lazy = true,
    -- },

    -- To make a plugin not be loaded
    -- {
    --   "NvChad/nvim-colorizer.lua",
    --   enabled = false
    -- },

    -- All NvChad plugins are lazy-loaded by default
    -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
    -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
    -- {
    --   "mg979/vim-visual-multi",
    --   lazy = false,
    -- }
}

return plugins
