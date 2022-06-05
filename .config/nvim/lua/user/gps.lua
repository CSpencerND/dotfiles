local status_ok, gps = pcall(require, "nvim-gps")
if not status_ok then
    return
end

local icons = require "user.icons"
local space = " "

-- local C = {
--     -- fg = "#161320",
--     -- fg = "#1e1e2a",
--     -- fg = "#232330",
--     bg = "#313244",
--     gray = "#575268",
--     fg = "#d9e0ee",
--     magenta = "#f892df",
--     purple = "#bda6f2",
--     blue = "#8ac2f7",
--     cyan = "#89dceb",
--     green = "#86fa95",
--     yellow = "#faf3b0",
--     orange = "#f8bd96",
--     red = "#f28f9d",
-- }

-- GpsNormal = { fg = C.gray, bg = C.bg, }
-- GpsItemKindFunction = { fg = C.purple, }
-- GpsItemKindMethod = { fg = C.purple, }
-- GpsItemKindConstructor = { fg = C.orange, }
-- GpsItemKindClass = { fg = C.orange, }
-- GpsItemKindEnum = { fg = C.orange, }
-- GpsItemKindEvent = { fg = C.purple, }
-- GpsItemKindInterface = { fg = C.cyan, }
-- GpsItemKindStruct = { fg = C.blue, }
-- GpsItemKindVariable = { fg = C.blue, }
-- GpsItemKindField = { fg = C.blue, }
-- GpsItemKindProperty = { fg = C.blue, }
-- GpsItemKindEnumMember = { fg = C.cyan, }
-- GpsItemKindConstant = { fg = C.blue, }
-- GpsItemKindKeyword = { fg = C.fg, }
-- GpsItemKindModule = { fg = C.fg, }
-- GpsItemKindValue = { fg = C.fg, }
-- GpsItemKindUnit = { fg = C.fg, }
-- GpsItemKindText = { fg = C.fg, }
-- GpsItemKindSnippet = { fg = C.fg, }
-- GpsItemKindFile = { fg = C.fg, }
-- GpsItemKindFolder = { fg = C.fg, }
-- GpsItemKindColor = { fg = C.fg, }
-- GpsItemKindReference = { fg = C.fg, }
-- GpsItemKindOperator = { fg = C.fg, }
-- GpsItemKindTypeParameter = { fg = C.fg, }

-- Customized config
gps.setup {
    icons = {
        ["class-name"] = "%#CmpItemKindClass#" .. icons.kind.Class .. "%*" .. space, -- Classes and class-like objects
        ["function-name"] = "%#CmpItemKindFunction#" .. icons.kind.Function .. "%*" .. space, -- Functions
        ["method-name"] = "%#CmpItemKindMethod#" .. icons.kind.Method .. "%*" .. space, -- Methods (functions inside class-like objects)
        ["container-name"] = "%#CmpItemKindProperty#" .. icons.type.Object .. "%*" .. space, -- Containers (example: lua tables)
        ["tag-name"] = "%#CmpItemKindKeyword#" .. icons.misc.Tag .. "%*" .. " ", -- Tags (example: html tags)
        ["mapping-name"] = "%#CmpItemKindProperty#" .. icons.type.Object .. "%*" .. space,
        ["sequence-name"] = "%#CmpItemKindProperty#" .. icons.type.Array .. "%*" .. space,
        ["null-name"] = "%#CmpItemKindField#" .. icons.kind.Field .. "%*" .. space,
        ["boolean-name"] = "%#CmpItemKindValue#" .. icons.type.Boolean .. "%*" .. space,
        ["integer-name"] = "%#CmpItemKindValue#" .. icons.type.Number .. "%*" .. space,
        ["float-name"] = "%#CmpItemKindValue#" .. icons.type.Number .. "%*" .. space,
        ["string-name"] = "%#CmpItemKindValue#" .. icons.type.String .. "%*" .. space,
        ["array-name"] = "%#CmpItemKindProperty#" .. icons.type.Array .. "%*" .. space,
        ["object-name"] = "%#CmpItemKindProperty#" .. icons.type.Object .. "%*" .. space,
        ["number-name"] = "%#CmpItemKindValue#" .. icons.type.Number .. "%*" .. space,
        ["table-name"] = "%#CmpItemKindProperty#" .. icons.ui.Table .. "%*" .. space,
        ["date-name"] = "%#CmpItemKindValue#" .. icons.ui.Calendar .. "%*" .. space,
        ["date-time-name"] = "%#CmpItemKindValue#" .. icons.ui.Table .. "%*" .. space,
        ["inline-table-name"] = "%#CmpItemKindProperty#" .. icons.ui.Calendar .. "%*" .. space,
        ["time-name"] = "%#CmpItemKindValue#" .. icons.misc.Watch .. "%*" .. space,
        ["module-name"] = "%#CmpItemKindModule#" .. icons.kind.Module .. "%*" .. space,
    },
    separator = "%#Comment#" .. " " .. icons.ui.ChevronRight .. "%*" .. " ",
    --
    -- depth = 0,
    --
    -- depth_limit_indicator = "..",
    -- text_hl = "LineNr",
}
