local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "prismals", "jsonls", "clangd", "astro" }

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

require("typescript-tools").setup {
    -- on_attach = function(client, bufnr)
    --     require("twoslash-queries").attach(client, bufnr)
    -- end,
    on_attach = on_attach,
    handlers = {
        ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
            if result.diagnostics == nil then
                return
            end

            -- ignore some tsserver diagnostics
            local idx = 1
            while idx <= #result.diagnostics do
                local entry = result.diagnostics[idx]

                local formatter = require("format-ts-errors")[entry.code]
                entry.message = formatter and formatter(entry.message) or entry.message

                -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
                if entry.code == 80001 then
                    -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
                    table.remove(result.diagnostics, idx)
                else
                    idx = idx + 1
                end
            end

            vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
        end,
    },
    settings = {
        -- spawn additional tsserver instance to calculate diagnostics on it
        separate_diagnostic_server = true,
        -- "change"|"insert_leave" determine when the client asks the server about diagnostic
        publish_diagnostic_on = "insert_leave",
        -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
        -- "remove_unused_imports"|"organize_imports") -- or string "all"
        -- to include all supported code actions
        -- specify commands exposed as code_actions
        expose_as_code_action = { "all" },
        -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
        -- not exists then standard path resolution strategy is applied
        tsserver_path = nil,
        -- tsserver_path = "/home/cs/.local/share/npm/lib/node_modules/typescript/lib/tsserver.js",
        -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
        -- (see 💅 `styled-components` support section)
        tsserver_plugins = {},
        -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
        -- memory limit in megabytes or "auto"(basically no limit)
        tsserver_max_memory = "auto",
        -- described below
        tsserver_format_options = {},
        tsserver_file_preferences = {},
        -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
        complete_function_calls = true,
        include_completions_with_insert_text = false,
        -- CodeLens
        -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
        -- possible values: ("off"|"all"|"implementations_only"|"references_only")
        code_lens = "off",
        -- by default code lenses are displayed on all referencable values and for some of you it can
        -- be too much this option reduce count of them by removing member references from lenses
        disable_member_code_lens = true,
        jsx_close_tag = {
            enable = true,
            filetypes = { "javascriptreact", "typescriptreact" },
        },
    },
}

-- lspconfig.tsserver.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     init_options = {
--         preferences = {
--             disableSuggestions = true,
--         },
--     },
--     handlers = {
--         ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
--             if result.diagnostics == nil then
--                 return
--             end
--
--             -- ignore some tsserver diagnostics
--             local idx = 1
--             while idx <= #result.diagnostics do
--                 local entry = result.diagnostics[idx]
--
--                 local formatter = require("format-ts-errors")[entry.code]
--                 entry.message = formatter and formatter(entry.message) or entry.message
--
--                 -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
--                 if entry.code == 80001 then
--                     -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
--                     table.remove(result.diagnostics, idx)
--                 else
--                     idx = idx + 1
--                 end
--             end
--
--             vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
--         end,
--     },
-- }

lspconfig.cssls.setup {
    capabilities = capabilities,
    settings = {
        css = {
            lint = {
                unknownAtRules = "ignore",
            },
        },
    },
}

lspconfig.tailwindcss.setup {
    settings = {
        tailwindCSS = {
            classAttributes = {
                "class",
                "className",
                "classNames",
                "class:list",
                "classList",
                "ngClass",

                -- headlessui_transition
                "enter",
                "enterFrom",
                "enterTo",
                "leave",
                "leaveFrom",
                "leaveTo",
            },
            experimental = {
                classRegex = {
                    -- { "tv\\((([^()]*|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                    { "tv\\(([^)(]*(?:\\([^)(]*(?:\\([^)(]*(?:\\([^)(]*\\)[^)(]*)*\\)[^)(]*)*\\)[^)(]*)*)\\)", "\"(.*?)\"" },
                },
            },
            lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning",
            },
            validate = true,
        },
    },
}

lspconfig.eslint.setup {
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
        "svelte",
        "graphql",
    },
    settings = {
        codeAction = {
            disableRuleComment = { enable = true, location = "separateLine" },
            showDocumentation = { enable = true },
        },
        -- experimental = { useFlatConfig = true },
        nodePath = "/home/cs/.local/share/fnm/aliases/default/bin/node",
        onIgnoredFiles = "off",
        options = {
            cache = true,
            fix = true,
            -- overrideConfigFile = lib.path.resolve_config "linters/eslint/dist/main.js",
            -- resolvePluginsRelativeTo = lib.path.resolve_config "linters/eslint/node_modules",
            useEslintrc = true,
        },
        packageManager = "pnpm",
        run = "onSave",
        workingDirectory = { mode = "auto" },
    },
}
