local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

-- local gps_ok, gps = pcall(require, "nvim-gps")
-- if not gps_ok then
--     return
-- end

local icons_ok, icons = pcall(require, "user.icons")
if not icons_ok then
    return
end

-------------------------------------------------------------------------------

local window_width_limit = 50

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand "%:t") ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > window_width_limit
    end,
}

-- local gps_cond = function()
--     return conditions.hide_in_width() and gps.is_available()
-- end

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

local lsp = {
    function(msg)
        msg = msg or "LS Inactive"
        local buf_clients = vim.lsp.buf_get_clients()
        if next(buf_clients) == nil then
            if type(msg) == "boolean" or #msg == 0 then
                return "LS Inactive"
            end
            return msg
        end

        local buf_ft = vim.bo.filetype
        local buf_client_names = {}

        -- add client
        for _, client in pairs(buf_clients) do
            if client.name ~= "null-ls" then
                table.insert(buf_client_names, client.name)
            end
        end

        -- add formatter
        local formatters = require "user.lsp.null-ls.formatters"
        local supported_formatters = formatters.list_registered(buf_ft)
        vim.list_extend(buf_client_names, supported_formatters)

        -- add linter
        local linters = require "user.lsp.null-ls.linters"
        local supported_linters = linters.list_registered(buf_ft)
        vim.list_extend(buf_client_names, supported_linters)

        return table.concat(buf_client_names, "  ")
        -- return "[" .. table.concat(buf_client_names, ", ") .. "]"
    end,
    icon = " ",
    color = { gui = "bold", fg = "#d6d3ea", bg = "#2d2b3a" },
    cond = conditions.hide_in_width,
    separator = { left = "", right = "" },
}

local branch = {
    "b:gitsigns_head",
    icon = " ",
    color = { gui = "bold", bg = "#363347" },
    cond = conditions.hide_in_width,
    separator = { left = "", right = "" },
}

local diff = {
    "diff",
    source = diff_source,
    symbols = {
        added = icons.git.Add .. " ",
        modified = icons.git.Mod .. " ",
        removed = icons.git.Remove .. " ",
    },
    cond = nil,
    color = { bg = "#2d2b3a" },
    separator = { left = "", right = "" },
}

local treesitter = {
    function()
        local b = vim.api.nvim_get_current_buf()
        if next(vim.treesitter.highlighter.active[b]) then
            return ""
        end
        return ""
    end,
    color = { fg = "#86daa5", }, -- bg = "#1c1c29"
    cond = conditions.hide_in_width,
}

local scrollbar = {
    function()
        local current_line = vim.fn.line "."
        local total_lines = vim.fn.line "$"
        local chars = {
            "  ",
            "▁▁",
            "▂▂",
            "▃▃",
            "▄▄",
            "▅▅",
            "▆▆",
            "▇▇",
            "██",
        }
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
    end,
    padding = { left = 0, right = 0 },
    color = { fg = "#f6c177", bg = "#21202a" },
    cond = nil,
}

-------------------------------------------------------------------------------

lualine.setup {
    options = {
        -- theme = "rose-pine",
        theme = require("user.statustheme"),
        --[[ theme = "tokyonight", ]]
        icons_enabled = true,

        -- component_separators = "",
        -- section_separators = "",
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        component_separators = "",
        section_separators = { left = "", right = "" },

        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = {
            {
                "mode",
                fmt = function(str)
                    return " " .. str:lower() -- :sub(1, 3)
                end,
            },
        },
        lualine_b = { branch, diff },
        lualine_c = {
            -- { gps.get_location, cond = gps_cond, color = { bg = "#1c1c29", fg =  "#1c1c29" } },
        },
        lualine_x = { "diagnostics", treesitter, lsp }, -- lsp },
        lualine_y = {
            { "filetype", color = { bg = "#393547", gui = "bold" } },
        },
        lualine_z = { "location", scrollbar }, -- progress
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
}
