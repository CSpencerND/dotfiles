-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.lint_on_save = false
lvim.transparent_window = false
lvim.colorscheme = "doom-one"
vim.g.material_style = "palenight"
vim.g.tokyonight_style = "storm" -- storm, night, day
vim.g.gruvbox_contrast_dark = "hard"

require("nvim-lsp-installer").settings { log_level = vim.log.levels.DEBUG }

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["<TAB>"] = ":bnext<cr>"
lvim.keys.normal_mode["<S-TAB>"] = ":bprevious<cr>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
lvim.keys.normal_mode["Y"] = "y$"
lvim.keys.normal_mode["<C-n>"] = ":lua require('material.functions').toggle_style()<cr>"
lvim.keys.visual_mode["p"] = [["_dP]]


-- emmet
vim.g.user_emmet_mode="n"
vim.g.user_emmet_leader_key=","


-- for finding syntax ids for non TS enabled languages
vim.cmd [[
map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
]]


-- -- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- lvim.builtin.telescope.on_config_done = function()
--   local actions = require "telescope.actions"
--   -- for input mode
--   lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
--   lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
--   -- for normal mode
--   lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
-- end


-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
}


-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.bufferline.active = true
lvim.builtin.lualine.style = "lvim" -- "none", "lvim", "default"


-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.playground.enable = true
lvim.builtin.treesitter.highlight.enabled = true
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.automatic_servers_installation = true
-- require("user.json_schemas").setup()


-- javascript
lvim.lang.javascript.formatters = {
  {
    exe = "prettier",
  },
}

-- lvim.lang.javascript.linters = {
--   {
--     exe = "eslint",
--   },
-- }

-- json
lvim.lang.json.formatters = {
  {
    exe = "prettier",
  },
}

-- lua
lvim.lang.lua.formatters = {
  {
    exe = "stylua",
  },
}

-- python
lvim.lang.python.formatters = {
  {
    exe = "black",
  },
}

-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--   },
-- }

-- c/cpp
lvim.lang.c.formatters = { { exe = "clang_format" } }
lvim.lang.cpp.formatters = lvim.lang.c.formatters


-- Additional Plugins
lvim.plugins = {
  { "zeekay/vim-beautify" },
  { "mattn/emmet-vim" },
  { "ckipp01/stylua-nvim" },
  { "morhetz/gruvbox" },
  { "dracula/vim" },
  { "lunarvim/colorschemes" },
  { "folke/tokyonight.nvim" },
  { "arzg/vim-substrata" },
  { "kyazdani42/nvim-palenight.lua" },
  { "marko-cerovac/material.nvim" },
  { "romgrk/doom-one.vim" },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
  },
  {
    "turbio/bracey.vim",
    cmd = {"Bracey", "BracyStop", "BraceyReload", "BraceyEval"},
    run = "npm install --prefix server",
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("user.colorizer").config()
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    -- event = "BufReadPre",
    config = function()
      require "user.blankline"
    end
  },
  {
    "unblevable/quick-scope",
    config = function()
      require "user.quickscope"
    end,
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("user.neoscroll").config()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle"
  },
  {
    "nvim-treesitter/playground",
    event = "BufRead",
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("user.hop").config()
    end,
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("user.numb").config()
    end,
  },
  {
    "rcarriga/nvim-notify",
    event = "BufRead",
    config = function()
      require("user.notify").config()
    end,
  },
  {
    "vuki656/package-info.nvim",
    config = function()
      require "user.package-info"
    end,
    ft = "json",
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
  },
}


-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
vim.cmd "set nowrap linebreak relativenumber"
vim.cmd "set colorcolumn=80"
vim.cmd "set tabstop=8 softtabstop=4 shiftwidth=4 expandtab"
