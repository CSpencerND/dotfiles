require("colorizer").setup({
    filetypes = { "*" },
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
        mode = "virtualtext", -- foreground, background,  virtualtext.
        virtualtext = " The quick brown fox", --   / 
        tailwind = "normal", -- "normal" / "lsp" / "both"
        -- parsers can contain values used in |user_default_options|
        sass = { enable = true, parsers = { css } }, -- Enable sass colors
    },
    -- all the sub-options of filetypes apply to buftypes
    buftypes = {},
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "*.css",
    },
    callback = function()
        require("colorizer").attach_to_buffer()
    end,
})
