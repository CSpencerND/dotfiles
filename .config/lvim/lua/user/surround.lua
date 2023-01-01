local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
    return
end

surround.setup {
    keymaps = { -- vim-surround style keymaps
        normal = "s",
        visual = "s",
        delete = "ds",
        change = "cs",
        insert = nil,
        insert_line = nil,
        normal_cur = nil,
        normal_line = nil,
        normal_cur_line = nil,
        visual_line = nil,
    },
}

-- surround.setup {
--     keymaps = { -- vim-surround style keymaps
--         -- insert = "<C-g>s",
--         -- insert_line = "<C-g>S",
--         normal = "s",
--         -- normal_cur = "ss",
--         -- normal_line = "<m-s>",
--         -- normal_cur_line = "SS",
--         visual = "s",
--         -- visual_line = "gS",
--         delete = "ds",
--         change = "cs",
--     },
-- }
