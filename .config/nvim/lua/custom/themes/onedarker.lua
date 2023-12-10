-- Credits to original https://github.com/one-dark
-- This is modified version of it

local M = {}

M.base_16 = {
    base00 = "#1E202a",
    base01 = "#353442",
    base02 = "#393847",
    base03 = "#434153",
    base04 = "#57556D",
    base05 = "#A2A1B5",
    base06 = "#B9B8C7",
    base07 = "#C4C3D0",
    base08 = "#e06c75",
    base09 = "#d19a66",
    base0A = "#e5c07b",
    base0B = "#98c379",
    base0C = "#56b6c2",
    base0D = "#61afef",
    base0E = "#c678dd",
    base0F = "#be5046",
}

M.base_30 = {
    white = "#A2A1B5",
    darker_black = "#1a1b24",
    black = M.base_16.base00, --  nvim bg
    black2 = "#25242E",
    one_bg = "#292833", -- real bg of onedark
    one_bg2 = "#353442",
    one_bg3 = "#393847",
    grey = "#434153",
    grey_fg = "#57556D",
    grey_fg2 = "#6E6C89",
    light_grey = "#6E6C89",
    red = "#e06c75",
    baby_pink = "#DE8C92",
    pink = "#ff75a0",
    line = "#302F3C", -- for lines like vertsplit
    green = "#98c379",
    vibrant_green = "#7eca9c",
    nord_blue = "#81A1C1",
    blue = "#61afef",
    yellow = "#e7c787",
    sun = "#EBCB8B",
    purple = "#de98fd",
    dark_purple = "#c882e7",
    teal = "#519ABA",
    orange = "#fca2aa",
    cyan = "#a3b8ef",
    statusline_bg = "#20222d",
    lightbg = "#2C2B36",
    pmenu_bg = "#61afef",
    folder_bg = "#61afef",
}

M.type = "dark"

M = require("base46").override_theme(M, "onedark")

return M
