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
lvim.keys.normal_mode["<leader>a"] = "ggVG"
lvim.keys.normal_mode["<leader>r"] = ":%s/"
-- lvim.keys.normal_mode["<C-S-o"] = "<C-i>"
lvim.keys.visual_mode["p"] = [["_dP]]


-- emmet
vim.g.user_emmet_mode="n"
vim.g.user_emmet_leader_key=","


-- for finding syntax ids for non TS enabled languages
-- vim.cmd [[
-- map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
-- ]]


local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}


-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
}


-- Builtins
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.bufferline.active = true
lvim.builtin.telescope.defaults.path_display = { "smart" }
lvim.builtin.project.patterns = { ".git" }
lvim.builtin.project.detection_methods = { "pattern" }
-- lvim.builtin.fancy_statusline = { active = true } -- enable/disable fancy statusline
-- if lvim.builtin.fancy_statusline.active then
  -- require("user.lualine").config()
-- end

-- lvim.builtin.nvimtree.side = "left"
-- lvim.builtin.nvimtree.show_icons.git = 0


-- Treesitter
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.autotag = {
  enable = true,
  disable = { "xml" },
}
lvim.builtin.treesitter.playground.enable = true
lvim.builtin.treesitter.indent.disable = { "python" }
-- lvim.builtin.treesitter.highlight.enabled = true


-- LSP
require("lvim.lsp.manager").setup("pylsp")
require("lvim.lsp.manager").setup("sumneko_lua")
require("lvim.lsp.manager").setup("eslint")
require("lvim.lsp.manager").setup("yamlls")
require("lvim.lsp.manager").setup("tsserver")
require("lvim.lsp.manager").setup("jsonls")
require("lvim.lsp.manager").setup("cssls")
require("lvim.lsp.manager").setup("html")
require("lvim.lsp.manager").setup("clangd")
require("lvim.lsp.manager").setup("emmet_ls")
require("lvim.lsp.manager").setup("bashls")
require("lvim.lsp.manager").setup("hls")

lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.automatic_servers_installation = true
-- require("user.json_schemas").setup()

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    { exe = "black" },
    { exe = "prettier" },
    { exe = "stylua" },
    { exe = "clang_format" },
}


-- Lualine
local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_c = { "diff" }
lvim.builtin.lualine.style = "lvim" -- "none", "lvim", "default"
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_y = {
  components.spaces,
  components.location
}


-- Additional Plugins
lvim.plugins = {
  { "psf/black" },
  { "dracula/vim" },
  { "lunarvim/colorschemes" },
  { "romgrk/doom-one.vim" },
  -- { "morhetz/gruvbox" },
  -- { "folke/tokyonight.nvim" },
  -- { "arzg/vim-substrata" },
  -- { "kyazdani42/nvim-palenight.lua" },
  -- { "marko-cerovac/material.nvim" },
  { "zeekay/vim-beautify" },
  { "mattn/emmet-vim" },
  { "mtdl9/vim-log-highlighting" },
  { "ckipp01/stylua-nvim" },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
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
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "BufReadPre",
  --   config = function()
  --     require "user.blankline"
  --   end
  -- },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
      vim.g.indent_blankline_buftype_exclude = {"terminal"}
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = true
    end
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("user.neoscroll").config()
    end,
  },
  -- {
  --   "simrat39/symbols-outline.nvim",
  --   cmd = "SymbolsOutline",
  -- },
  -- {
  --   "unblevable/quick-scope",
  --   config = function()
  --     require "user.quickscope"
  --   end,
  -- },
  -- {
  --   "folke/trouble.nvim",
  --   cmd = "TroubleToggle"
  -- },
  -- {
  --   "nvim-treesitter/playground",
  --   event = "BufRead",
  -- },
  -- {
  --   "phaazon/hop.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("user.hop").config()
  --   end,
  -- },
  -- {
  --   "nacro90/numb.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("user.numb").config()
  --   end,
  -- },
  -- {
  --   "rcarriga/nvim-notify",
  --   event = "BufRead",
  --   config = function()
  --     require("user.notify").config()
  --   end,
  -- },
  -- {
  --   "vuki656/package-info.nvim",
  --   config = function()
  --     require "user.package-info"
  --   end,
  --   ft = "json",
  -- },
  -- {
  --   "folke/todo-comments.nvim",
  --   event = "BufRead",
  -- },
  -- {
  --   "lewis6991/spellsitter.nvim",
  --   config = function()
  --     require('spellsitter').setup()
  --   end
  -- },
}


-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  {
    "BufWinEnter", -- When to take effect
    "*", -- filetype or name
    "setlocal colorcolumn=80"
  },
  {
    "BufWinEnter", -- When to take effect
    "*", -- filetype or name
    "nnoremap <C-i> <C-i>"
  },
  {
    "BufWinEnter", -- When to take effect
    "*.lua", -- filetype or name
    "setlocal softtabstop=2 shiftwidth=2"
      -- expandtab \z
      -- tabstop=8 
      -- relativenumber linebreak nowrap \z
      -- hidden \z
      -- colorcolumn=80 \z
    -- "
  },
}


vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.linebreak = true
vim.opt.wrap = true
vim.opt.hidden = true
-- vim.opt.colorcolumn = "80"
