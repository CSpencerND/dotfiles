local display_null_ls_status = function(message)
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
        if type(message) == "boolean" or #message == 0 then
            return ""
        end
        return message
    end
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    local is_null_ls_installed, null_ls = pcall(require, "null-ls")
    if is_null_ls_installed then
        local formatters_for_this_filetype = {}
        for k, v in pairs(null_ls.builtins.formatting) do
            if vim.tbl_contains(v.filetypes, vim.bo.filetype) then
                table.insert(formatters_for_this_filetype, k)
            end
        end
        vim.list_extend(buf_client_names, formatters_for_this_filetype)
    end

    local linters = require "user.lsp.null-ls.linters"
    local supported_linters = linters.list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_linters)

    local first_few = vim.list_slice(buf_client_names, 1, 2)
    local extra_count = #buf_client_names - 2
    local output = table.concat(first_few, ", ")
    if extra_count > 0 then
        output = output .. " +" .. extra_count
    end
    return output
end
