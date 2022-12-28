-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.colorscheme = "kanagawa"

lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.diagnostics.float.focusable = true
lvim.builtin.treesitter.autotag = true
lvim.builtin.which_key.setup.layout.align = "center"

reload "user.plugins"
reload "user.options"
reload "user.keymaps"
reload "user.autocommands"
reload "user.lsp"
reload "user.smoothie"
reload "user.harpoon"
reload "user.surround"
reload "user.inlay-hints"
reload "user.whichkey"
reload "user.hop"
reload "user.colorizer"
reload "user.registers"
reload "user.scrollbar"
reload "user.telescope"
