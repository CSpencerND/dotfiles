local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    c = {
        name = "Typescript",
        i = { "<cmd>TypescriptAddMissingImports<Cr>", "AddMissingImports" },
        o = { "<cmd>TypescriptOrganizeImports<cr>", "OrganizeImports" },
        u = { "<cmd>TypescriptRemoveUnused<Cr>", "RemoveUnused" },
        r = { "<cmd>TypescriptRenameFile<Cr>", "RenameFile" },
        f = { "<cmd>TypescriptFixAll<Cr>", "FixAll" },
        g = {
            "<cmd>TypescriptGoToSourceDefinition<Cr>",
            "GoToSourceDefinition",
        },
    },
}

which_key.register(mappings, opts)

local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
    return
end

vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
}
vim.g.indentLine_enabled = 1
-- vim.g.indent_blankline_char = "│"
vim.g.indent_blankline_char = "▏"
-- vim.g.indent_blankline_char = "▎"
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
    "class",
    "return",
    "function",
    "method",
    "^if",
    "^while",
    "jsx_element",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
    "if_statement",
    "else_clause",
    "jsx_element",
    "jsx_self_closing_element",
    "try_statement",
    "catch_clause",
    "import_statement",
    "operation_type",
}
vim.wo.colorcolumn = "99999"

vim.cmd [[highlight IndentBlanklineIndent1     guifg=#7F3A36 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2     guifg=#7C6A32 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3     guifg=#3A5050 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4     guifg=#7F3C1D gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5     guifg=#4C6F4C gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6     guifg=#6E4D5C gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar guifg=#612078 gui=nocombine]]
vim.cmd [[highlight NvimTreeIndentMarker       guifg=#2E31A8 gui=nocombine]]

vim.opt.list = true

indent_blankline.setup {
    show_current_context = true,
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}
