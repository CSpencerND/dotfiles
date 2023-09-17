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
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
        config = {
            -- Languages that have a single comment style
            typescript = "// %s",
            css = "/* %s */",
            scss = "/* %s */",
            html = "<!-- %s -->",
            svelte = "<!-- %s -->",
            vue = "<!-- %s -->",
            json = "",
        },
    },
    indent = {
        enable = true,
        disable = { "yaml", "python" },
    },
    autotag = {
        enable = true,
        -- enable_close_on_slash = false,
    },
    textobjects = {
        swap = {
            enable = false,
            -- swap_next = textobj_swap_keymaps,
        },
        -- move = textobj_move_keymaps,
        select = {
            enable = false,
            -- keymaps = textobj_sel_keymaps,
        },
    },
    textsubjects = {
        enable = false,
        keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
    },
    playground = {
        enable = false,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
        },
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 750, -- Do not enable for files with more than 1000 lines, int
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
    sync_root_with_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 200,
    },
    view = {
        width = {
            min = 30,
            max = -1,
            padding = 2,
        },
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
        group_empty = false,
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
                folder_arrow = false,
            },
            glyphs = {
                folder = {
                    -- arrow_open = "",
                    -- arrow_closed = "󰧞",
                    -- arrow_open = "",
                    -- arrow_closed = "",
                },
            },
        },
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },
        open_file = {
            quit_on_open = false,
            resize_window = false,
            window_picker = {
                enable = true,
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
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
