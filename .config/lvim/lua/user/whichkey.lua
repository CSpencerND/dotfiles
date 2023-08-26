local mappings = lvim.builtin.which_key.mappings

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

mappings.x = { "<cmd>!chmod +x %<CR>", "chmod" }
mappings.c = nil
mappings.L = nil
mappings.s = nil
mappings.w = nil
mappings[";"] = nil
mappings["gs"] = nil

-- mappings["b"] = {
--     "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{initial_mode='normal'})<cr>",
--     "Buffers",
-- }
-- mappings["b"] = { "<cmd>Telescope buffers<cr>", "Buffers" }
mappings["m"] = { "<cmd>:lua MiniMap.toggle()<CR>", "MiniMap Toggle" }
mappings["k"] = { "<cmd>InspectTwoslashQueries<CR>", "Twoslash Query" }
mappings["z"] = { "<cmd>:ZenMode<cr>", "Zen Mode" }
mappings["v"] = { "<cmd>vsplit<cr>", "vsplit" }
mappings["h"] = { "<cmd>nohlsearch<cr>", "nohl" }
mappings["q"] =
    { '<cmd>lua require("user.functions").smart_quit()<CR>', "Quit" }
mappings["/"] = {
    '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>',
    "Comment",
}
mappings["w"] = { "<cmd>bdelete!<CR>", "Close Buffer" }
mappings["gy"] = "Link"

mappings["r"] = {
    name = "Replace",
    r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
    w = {
        "<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
        "Replace Word",
    },
    f = {
        "<cmd>lua require('spectre').open_file_search()<cr>",
        "Replace Buffer",
    },
    g = { "<cmd>lua require('renamer').rename()<cr>", "Renamer" },
    ["/"] = { ":%s/", "sed" },
    s = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "super sed" },
}

mappings["d"] = {
    name = "Debug",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
}

mappings["f"] = {
    name = "Find",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    p = {
        "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
        "Colorscheme with Preview",
    },
    f = { "<cmd>Telescope find_files<cr>", "Find files" },
    t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
    s = { "<cmd>Telescope grep_string<cr>", "Find String" },
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
    H = { "<cmd>Telescope highlights<cr>", "Highlights" },
    i = {
        "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>",
        "Media",
    },
    l = { "<cmd>Telescope resume<cr>", "Last Search" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
}

mappings["l"] = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
    w = {
        "<cmd>Telescope diagnostics<cr>",
        "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
    F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    h = { "<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Toggle Hints" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
        "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
        "Next Diagnostic",
    },
    k = {
        "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
        "Prev Diagnostic",
    },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    t = {
        '<cmd>lua require("user.functions").toggle_diagnostics()<cr>',
        "Toggle Diagnostics",
    },
    -- c = {
    --     "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<cr>",
    --     "Get Capabilities",
    -- },
    -- c = { "<cmd>lua require('user.lsp').server_capabilities()<cr>", "Get Capabilities" },

    -- H = { "<cmd>IlluminationToggle<cr>", "Toggle Doc HL" },
    -- v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Virtual Text" },
    -- l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    -- o = { "<cmd>SymbolsOutline<cr>", "Outline" },
    -- q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    -- R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
    -- s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    -- S = {
    --     "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    --     "Workspace Symbols",
    -- },
    -- u = { "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet" },
}

mappings["t"] = {
    name = "Tab",
    f = {
        "<cmd>lua require('telescope').extensions['telescope-tabs'].list_tabs(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal', prompt_title='Tabs'})<cr>",
        "Find Tab",
    },
    t = { "<cmd>tabnew<cr>", "New Tab" },
    c = { "<cmd>tabclose<cr>", "Close Tab" },
    o = { "<cmd>tabonly<cr>", "Only Tab" },
    n = { "<cmd>tabnext<cr>", "Next Tab" },
    p = { "<cmd>tabprevious<cr>", "Prev Tab" },
}

mappings["o"] = {
    name = "Options",
    c = { "<cmd>lua lvim.builtin.cmp.active = false<cr>", "Completion off" },
    C = { "<cmd>lua lvim.builtin.cmp.active = true<cr>", "Completion on" },
    w = {
        '<cmd>lua require("user.functions").toggle_option("wrap")<cr>',
        "Wrap",
    },
    r = {
        '<cmd>lua require("user.functions").toggle_option("relativenumber")<cr>',
        "Relative",
    },
    l = {
        '<cmd>lua require("user.functions").toggle_option("cursorline")<cr>',
        "Cursorline",
    },
    s = {
        '<cmd>lua require("user.functions").toggle_option("spell")<cr>',
        "Spell",
    },
    t = { '<cmd>lua require("user.functions").toggle_tabline()<cr>', "Tabline" },
}

-- mappings["n"] = {
--     name = "Notes",
--     c = { "<cmd>Telekasten show_calendar<cr>", "Calendar" },
--     n = { "<cmd>Telekasten new_note<cr>", "Note" },
--     f = { "<cmd>Telekasten find_notes<cr>", "Find" },
--     F = { "<cmd>Telekasten find_daily_notes<cr>", "Find Journal" },
--     j = { "<cmd>Telekasten goto_today<cr>", "Journal" },
--     p = { "<cmd>Telekasten panel<cr>", "Panel" },
--     t = { "<cmd>Telekasten toggle_todo<cr>", "Toggle Todo" },
-- }

local m_opts = {
    mode = "n", -- NORMAL mode
    prefix = "m",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local m_mappings = {
    g = {
        '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>',
        "Harpoon UI",
    },
    m = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" },

    n = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" },
    p = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" },

    ["/"] = { "<cmd>Telescope harpoon marks<cr>", "Search Files" },

    a = { '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', "Go To 1" },
    s = { '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', "Go To 2" },
    d = { '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', "Go To 3" },
    f = { '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', "Go To 4" },
    q = { '<cmd>lua require("harpoon.ui").nav_file(5)<cr>', "Go To 5" },
    w = { '<cmd>lua require("harpoon.ui").nav_file(6)<cr>', "Go To 6" },
    e = { '<cmd>lua require("harpoon.ui").nav_file(7)<cr>', "Go To 7" },
    r = { '<cmd>lua require("harpoon.ui").nav_file(8)<cr>', "Go To 8" },

    -- l = { "<cmd>lua require('user.bfs').open()<cr>", "Buffers" },
    -- a = { "<cmd>silent BookmarkAnnotate<cr>", "Annotate" },
    -- c = { "<cmd>silent BookmarkClear<cr>", "Clear" },
    -- b = { "<cmd>silent BookmarkToggle<cr>", "Toggle" },
    -- j = { "<cmd>silent BookmarkNext<cr>", "Next" },
    -- k = { "<cmd>silent BookmarkPrev<cr>", "Prev" },
    -- S = { "<cmd>silent BookmarkShowAll<cr>", "Prev" },
    -- s = {
    --   "<cmd>lua require('telescope').extensions.vim_bookmarks.all({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>",
    --   "Show",
    -- },
    -- x = { "<cmd>BookmarkClearAll<cr>", "Clear All" },
}

local g_opts = {
    mode = "n", -- NORMAL mode
    prefix = "g",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local g_mappings = {
    j = { "<cmd>TSJJoin<cr>", "join array" },
    k = { "<cmd>TSJSplit<cr>", "split array" },
    m = { "<cmd>TSJToggle<cr>", "toggle array" },
}

which_key.register(m_mappings, m_opts)
which_key.register(g_mappings, g_opts)
