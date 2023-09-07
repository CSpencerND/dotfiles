local M = {}

local actions = require "telescope.actions"

M.telescope = {
    defaults = {
        mappings = {
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },
    },
}

local cmp = require "cmp"

M.cmp = {
    mapping = {
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),

        ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }, { "i" }),
        ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }, { "i" }),

        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(8),
        ["<C-u>"] = cmp.mapping.scroll_docs(-8),

        ["<C-c>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },

        ["<Tab>"] = {},
    },
}

M.treesitter = {
    ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "python",
        "yaml",
        "markdown",
        "markdown_inline",
    },
    indent = {
        enable = true,
    },
}

M.mason = {
    ensure_installed = {
        -- lua
        "lua-language-server",
        "stylua",

        -- web dev
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "tailwindcss-language-server",
        "prettier",
        "prisma-language-server",

        -- python
        "python-lsp-server",
        "black",

        -- c/cpp
        "clangd",
        "clang-format",
    },
}

local function tree_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close")
end

M.nvimtree = {
    on_attach = tree_on_attach,
    hijack_netrw = true,
    disable_netrw = true,
    hijack_directories = {
        enable = false,
    },
    update_cwd = true,
    respect_buf_cwd = true,
    sync_root_with_cwd = false,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 200,
    },
    view = {
        adaptive_size = false,
        width = 30,
        hide_root_folder = false,
        signcolumn = "yes",
    },
    filters = {
        dotfiles = true,
        custom = { "node_modules", "\\.cache" },
        exclude = {},
        git_ignored = false,
    },
    modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
    },
    renderer = {
        group_empty = true,
        full_name = true,
        root_folder_label = function(root_cwd)
            return "󱧳 " .. vim.fn.fnamemodify(root_cwd, ":t")
        end,
        indent_width = 4,
        highlight_git = true,
        indent_markers = {
            enable = true,
            inline_arrows = false,
            icons = {
                corner = "╰",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            },
        },
        icons = {
            show = {
                git = true,
                file = true,
                folder = true,
                folder_arrow = true,
            },
            glyphs = {
                folder = {
                    arrow_open = "",
                    arrow_closed = "󰧞",
                    -- arrow_open = "",
                    -- arrow_closed = "",
                },
            },
        },
    },
}

M.colorizer = {
    user_default_options = {
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        names = false, -- "Name" codes like Blue or blue
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        tailwind = "lsp", -- "normal" / "lsp" / "both"
    },
}

return M

-- {
--     name = "copilot",
--     -- keyword_length = 0,
--     max_item_count = 3,
--     trigger_characters = {
--         {
--             ".",
--             ":",
--             "(",
--             "'",
--             '"',
--             "[",
--             ",",
--             "#",
--             "*",
--             "@",
--             "|",
--             "=",
--             "-",
--             "{",
--             "/",
--             "\\",
--             "+",
--             "?",
--             " ",
--             -- "\t",
--             -- "\n",
--         },
--     },
-- },
