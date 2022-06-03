local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
ft_to_parser.motoko = "typescript"

configs.setup({
	ensure_installed = "all", -- one of "all" or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		-- use_languagetree = true,
		enable = true, -- false will disable the whole extension
		-- disable = { "css", "html" }, -- list of language that will be disabled
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "yaml" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	autotag = {
		enable = true,
		disable = { "" },
	},
	playground = {
		enable = true,
	},
	rainbow = {
		enable = true,
		colors = {
			-- "#ddb6f2",
			-- "#e8a2af",
			-- "#f8bd96",
			-- "#fae3b0",
			-- "#abe9b3",
			-- "#89dceb",

			"#bd93f9",
			"#ff79c6",
			"#ffb86c",
			"#f1fa8c",
			"#50fa7b",
			"#8be9fd",

			-- "Gold",
			-- "Orchid",
			-- "DodgerBlue",
			-- "Cornsilk",
			-- "Salmon",
			-- "LawnGreen",
		},
		disable = { "" },
	},
})
