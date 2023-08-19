local api = vim.api

local M = {}

function M.is_hide_buf(bufnr)
    return vim.fn.bufnr(bufnr) == -1
end

function M.get_buf_file_name(bufnr)
    return api.nvim_buf_get_name(bufnr):match("^.+/(.+)$")
end

function M.is_empty_buf(bufnr)
    return api.nvim_buf_get_name(bufnr) == ""
end

function M.create_floating_window()
    local columns, lines = vim.api.nvim_win_get_width(0), vim.api.nvim_win_get_height(0)

    local width = math.min(columns - 4, math.max(80, columns - 20))
    local height = math.min(lines - 4, math.max(20, lines - 10))

    local bufnr = vim.api.nvim_create_buf(false, true)
    local winid = vim.api.nvim_open_win(bufnr, true, {
        title = "float",
        title_pos = "center",
        relative = "win",
        width = width,
        height = height,
        style = 'minimal',
        border = "rounded",
        row = math.floor(((lines - height) / 2) - 1),
        col = math.floor((columns - width) / 2)
    })

    return bufnr, winid
end

return M