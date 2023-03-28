-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
reload "user.plugins"
reload "user.options"
reload "user.keymaps"
reload "user.autocommands"
reload "user.lsp"
reload "user.smoothie"
reload "user.harpoon"
reload "user.hop"
reload "user.surround"
reload "user.colorizer"
reload "user.registers"
reload "user.inlay-hints"
reload "user.whichkey"
reload "user.telescope"
reload "user.scrollbar"

lvim.colorscheme = "tokyonight-night"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.diagnostics.float.focusable = true
lvim.builtin.treesitter.autotag = true
lvim.builtin.which_key.setup.layout.align = "center"
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.matchup.enable = true

lvim.builtin.indentlines.options = {
    show_current_context = true,
    show_first_indent_level = false,
    use_treesitter = true,
    space_char_blankline = " ",
    show_current_context_start = true,
}
