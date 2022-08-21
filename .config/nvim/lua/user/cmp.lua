local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

local compare = require "cmp.config.compare"

require("luasnip/loaders/from_vscode").lazy_load()

-- local check_backspace = function()
--     local col = vim.fn.col "." - 1
--     return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
-- end

local check_backspace = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api
                .nvim_buf_get_lines(0, line - 1, line, true)[1]
                :sub(col, col)
                :match "%s"
            == nil
end

local icons = require "user.icons"
--   פּ ﯟ   some other good icons
local kind_icons = icons.kind
-- find more here: https://www.nerdfonts.com/cheat-sheet

vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm { select = true },

        --[[ ["<Tab>"] = cmp.mapping(function(fallback) ]]
        --[[     if cmp.visible() then ]]
        --[[         cmp.select_next_item() ]]
        --[[     elseif luasnip.expandable() then ]]
        --[[         luasnip.expand() ]]
        --[[     elseif luasnip.expand_or_jumpable() then ]]
        --[[         luasnip.expand_or_jump() ]]
        --[[     elseif check_backspace() then ]]
        --[[         fallback() ]]
        --[[     else ]]
        --[[         fallback() ]]
        --[[     end ]]
        --[[ end, { ]]
        --[[     "i", ]]
        --[[     "s", ]]
        --[[ }), ]]
        --[[ ["<S-Tab>"] = cmp.mapping(function(fallback) ]]
        --[[     if cmp.visible() then ]]
        --[[         cmp.select_prev_item() ]]
        --[[     elseif luasnip.jumpable(-1) then ]]
        --[[         luasnip.jump(-1) ]]
        --[[     else ]]
        --[[         fallback() ]]
        --[[     end ]]
        --[[ end, { ]]
        --[[     "i", ]]
        --[[     "s", ]]
        --[[ }), ]]
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.kind = kind_icons[vim_item.kind]

            if entry.source.name == "emoji" then
                vim_item.kind = icons.misc.Smiley
                vim_item.kind_hl_group = "CmpItemKindEmoji"
            end

            if entry.source.name == "crates" then
                vim_item.kind = icons.misc.Package
                vim_item.kind_hl_group = "CmpItemKindCrate"
            end

            -- NOTE: order matters
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                nvim_lua = " ",
                npm = " ",
                crate = " ",
                luasnip = "[Snip]",
                buffer = "[Buf]",
                path = "[Path]",
                emoji = "",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        -- { name = "nvim_lsp" },
        {
            name = "nvim_lsp",
            filter = function(entry, ctx)
                vim.pretty_print()
                local kind =
                    require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
                -- vim.bo.filetype
                if
                    kind == "Snippet"
                    and ctx.prev_context.filetype == "java"
                then
                    return true
                end
            end,
            group_index = 2,
        },

        { name = "nvim_lua", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "path", group_index = 2 },
        { name = "npm", group_index = 2 },
        -- { name = "crates", group_index = 2 },
        { name = "emoji", group_index = 2 },

        -- { name = "nvim_lua" },
        -- { name = "luasnip" },
        -- { name = "npm" },
        -- { name = "crates" },
        -- { name = "buffer" },
        -- { name = "path" },
    },

    sorting = {
        priority_weight = 2,
        comparators = {
            -- require("copilot_cmp.comparators").prioritize,
            -- require("copilot_cmp.comparators").score,
            compare.offset,
            compare.exact,
            -- compare.scopes,
            compare.score,
            compare.recently_used,
            compare.locality,
            -- compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
            -- require("copilot_cmp.comparators").prioritize,
            -- require("copilot_cmp.comparators").score,
        },
    },

    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        documentation = {
            border = "rounded",
            winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
        },
        completion = {
            border = "rounded",
            winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
        },
    },
    experimental = {
        ghost_text = true,
    },
}
