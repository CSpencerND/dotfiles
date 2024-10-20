local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
    return
end

catppuccin.setup {
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
    },
    transparent_background = false,
    term_colors = false,
    compile = {
        enabled = false,
        path = vim.fn.stdpath "cache" .. "/catppuccin",
    },
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
        coc_nvim = false,
        lsp_trouble = false,
        cmp = true,
        lsp_saga = false,
        gitgutter = false,
        gitsigns = true,
        leap = false,
        telescope = true,
        nvimtree = {
            enabled = true,
            show_root = true,
            transparent_panel = false,
        },
        neotree = {
            enabled = false,
            show_root = true,
            transparent_panel = false,
        },
        dap = {
            enabled = false,
            enable_ui = false,
        },
        which_key = false,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
        },
        dashboard = true,
        neogit = false,
        vim_sneak = false,
        fern = false,
        barbar = false,
        bufferline = true,
        markdown = true,
        lightspeed = false,
        ts_rainbow = false,
        hop = true,
        notify = true,
        telekasten = true,
        symbols_outline = true,
        mini = false,
        aerial = false,
        vimwiki = true,
        beacon = true,
    },
    color_overrides = {
        mocha = {
            -- rosewater = "#f5e0dc",
            -- flamingo = "#f2cdcd",
            -- pink = "#f5c2e7",
            -- mauve = "#cba6f7",
            -- red = "#f38ba8",
            -- maroon = "#eba0ac",
            -- peach = "#fab387",
            -- yellow = "#f9e2af",
            -- green = "#a6e3a1",
            -- teal = "#94e2d5",
            -- sky = "#89dceb",
            -- sapphire = "#74c7ec",
            -- blue = "#89b4fa",
            -- lavender = "#b4befe",
            --
            -- text = "#cdd6f4",
            -- subtext1 = "#bac2de",
            -- subtext0 = "#a6adc8",
            -- overlay2 = "#9399b2",
            -- overlay1 = "#7f849c",
            -- overlay0 = "#6c7086",
            -- surface2 = "#585b70",
            -- surface1 = "#45475a",
            -- surface0 = "#313244",

            base = "#1e1e27",
            -- mantle = "#181825",
            -- crust = "#11111b",
        },
    },
    custom_highlights = {},
}

-- catppuccin.setup({
-- 	transparent_background = false,
-- 	term_colors = false,
-- 	styles = {
-- 		comments = "italic",
-- 		functions = "italic",
-- 		keywords = "italic",
-- 		strings = "NONE",
-- 		variables = "NONE",
-- 	},
-- 	integrations = {
-- 		treesitter = true,
-- 		native_lsp = {
-- 			enabled = true,
-- 			virtual_text = {
-- 				errors = "italic",
-- 				hints = "italic",
-- 				warnings = "italic",
-- 				information = "italic",
-- 			},
-- 			underlines = {
-- 				errors = "underline",
-- 				hints = "underline",
-- 				warnings = "underline",
-- 				information = "underline",
-- 			},
-- 		},
-- 		lsp_trouble = true,
-- 		lsp_saga = false,
-- 		gitgutter = false,
-- 		gitsigns = true,
-- 		telescope = true,
-- 		nvimtree = {
-- 			enabled = true,
-- 			show_root = true,
-- 			transparent_panel = false,
-- 		},
--
-- 		which_key = true,
-- 		dashboard = true,
-- 		neogit = false,
-- 		vim_sneak = false,
-- 		fern = false,
-- 		barbar = false,
-- 		bufferline = true,
-- 		markdown = true,
-- 		lightspeed = false,
-- 		hop = true,
-- 		indent_blankline = { enabled = true, colored_indent_levels = true },
-- 		ts_rainbow = true,
-- 	},
-- })
