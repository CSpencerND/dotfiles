local M = {}

M.type = "dark"

---@type Base16Table
M.base_16 = {
    base00 = "#1C1E26",
    base01 = "#232530",
    base02 = "#2E303E",
    base03 = "#6F6F70",
    base04 = "#9DA0A2",
    base05 = "#CBCED0",
    base06 = "#DCDFE4",
    base07 = "#E3E6EE",
    base08 = "#EE64AC",
    base09 = "#E58D7D",
    base0A = "#EFB993",
    base0B = "#EFAF8E",
    base0C = "#25B0BC",
    base0D = "#F075B5",
    base0E = "#B072D1",
    base0F = "#E4A382",
}

---@type Base30Table
M.base_30 = {
    white = "#FFFFFF",
    darker_black = "#16161c",
    black = M.base_16.base00, --  nvim bg
    black2 = M.base_16.base01,
    one_bg = M.base_16.base00,
    one_bg2 = M.base_16.base01,
    one_bg3 = M.base_16.base02,
    grey = M.base_16.base02,
    grey_fg = "#3F4355",
    grey_fg2 = "#50566C",
    light_grey = "#616884",
    red = M.base_16.base08,
    baby_pink = "#a72e5b",
    pink = M.base_16.base0D,
    line = "#101116", -- for lines like vertsplit
    green = "#AAD84C",
    vibrant_green = "#b9e75b",
    nord_blue = "#18a3af",
    blue = M.base_16.base0C,
    seablue = "#169AC9",
    yellow = "#fdb830",
    sun = "#ffc038",
    purple = "#da70d6",
    dark_purple = "#c65cc2",
    teal = "#749689",
    orange = "#FFA500",
    cyan = M.base_16.base0E,
    statusline_bg = M.base_16.base01,
    lightbg = M.base_16.base02,
    pmenu_bg = "#15bf84",
    folder_bg = M.base_16.base0C,
}

M.polish_hl = {
    Include = { fg = M.base_16.base0E, bold = true },
    ["@property"] = { fg = M.base_16.base0E },
    ["@tag.delimiter"] = { fg = M.base_16.base05 },
    ["@punctuation.bracket"] = { fg = M.base_30.yellow },
    ["@punctuation.delimiter"] = { fg = M.base_30.yellow },
}

return M
