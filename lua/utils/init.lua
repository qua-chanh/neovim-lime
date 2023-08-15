local api = vim.api

local M = {}

function M.get_buf_file_name(bufnr)
    return api.nvim_buf_get_name(bufnr):match("^.+/(.+)$")
end

function M.is_empty_buf(bufnr)
    return api.nvim_buf_get_name(bufnr) == ""
end

return M