---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
    ------------------------------- base46 -------------------------------------
    theme = "tokyodark",
    theme_toggle = { "tokyodark", "one_light" },

    hl_override = highlights.override,
    hl_add = highlights.add,

    lsp_semantic_tokens = true,

    telescope = { style = "bordered" }, -- borderless / bordered

    extended_integrations = { "notify" }, -- these aren't compiled by default, ex: "alpha", "notify"

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

    cheatsheet = { theme = "simple" }, -- simple/grid

    lsp = {
        -- show function signatures i.e args as you type
        signature = {
            disabled = false,
            silent = true, -- silences 'no signature help available' message from appearing
        },
    },
}

M.plugins = "custom.plugins"
M.lazy_nvim = {
    ui = {
        border = "rounded",
    },
    checker = {
        enabled = true,
    },
}

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
