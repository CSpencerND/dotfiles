---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
    ------------------------------- base46 -------------------------------------
    theme = "onedarker",
    theme_toggle = { "onedarker", "one_light" },
    -- changed_themes = {
    --     onedarker = {
    --         base_16 = {
    --             base00 = "#1f1f28"
    --         }
    --     },
    --     onedarker = {
    --         base_16 = {
    --             base00 = "#1f1f28"
    --         }
    --     }
    -- },

    hl_override = highlights.override,
    hl_add = highlights.add,

    transparency = false,
    lsp_semantic_tokens = true, -- needs nvim v0.9, just adds highlight groups for lsp semantic tokens

    extended_integrations = { "notify" }, -- these aren't compiled by default, ex: "alpha", "notify"

    -- cmp themeing
    cmp = {
        icons = true,
        lspkind_text = true,
        style = "flat_dark", -- default/flat_light/flat_dark/atom/atom_colored
        border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
        selected_item_bg = "colored", -- colored / simple
    },

    telescope = { style = "bordered" }, -- borderless / bordered

    ------------------------------- nvchad_ui modules -----------------------------
    statusline = {
        theme = "default", -- default/vscode/vscode_colored/minimal
        -- default/round/block/arrow separators work only for default statusline theme
        -- round and block will work for minimal theme only
        separator_style = "default",
        overriden_modules = nil,
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
        show_numbers = false,
        enabled = true,
        lazyload = false,
        overriden_modules = nil,
    },

    nvdash = {
        load_on_startup = true,

        buttons = {
            { "  Find File", "Spc f f", "Telescope find_files" },
            { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
            { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
            { "  Bookmarks", "Spc m a", "Telescope marks" },
            { "  Themes", "Spc t h", "Telescope themes" },
            { "  Mappings", "Spc c h", "NvCheatsheet" },
            { "  Config", "Spc c c", "Configuration" },
        },

        header = {
            [[                                                     ]],
            [[  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ ]],
            [[  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ ]],
            [[ ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ ]],
            [[ ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  ]],
            [[ ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ ]],
            [[ ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ ]],
            [[ ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ ]],
            [[    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    ]],
            [[          ░    ░  ░    ░ ░        ░   ░         ░    ]],
            [[                                 ░                   ]],
            [[                                                     ]],
        },

        -- header = {
        --   [[                                       ]],
        --   [[    ▄   ▄███▄   ████▄     ▄   ▄█ █▀▄▀█ ]],
        --   [[     █  █▀   ▀  █   █      █  ██ █ █ █ ]],
        --   [[ ██   █ ██▄▄    █   █ █     █ ██ █ ▄ █ ]],
        --   [[ █ █  █ █▄   ▄▀ ▀████  █    █ ▐█ █   █ ]],
        --   [[ █  █ █ ▀███▀           █  █   ▐    █  ]],
        --   [[ █   ██                  █▐        ▀   ]],
        --   [[                         ▐             ]],
        --   [[                                       ]],
        -- },
    },

    cheatsheet = { theme = "grid" }, -- simple/grid

    lsp = {
        -- show function signatures i.e args as you type
        signature = {
            disabled = false,
            silent = true, -- silences 'no signature help available' message from appearing
        },
    },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
