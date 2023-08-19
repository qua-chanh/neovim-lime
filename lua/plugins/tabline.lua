local bo = vim.bo
local cmd = vim.cmd
local api = vim.api

local utils = require("utils")

local M = {}

M.buffers = {}

function M.load()
    vim.loop.new_async(vim.schedule_wrap(function()
        local left = ""
        local buffers = {}
        for bufnr = 1, vim.fn.bufnr('$') do
            if not utils.is_hide_buf(bufnr) and not utils.is_empty_buf(bufnr) then 
                table.insert(buffers, bufnr)
                left = left .. " " .. utils.get_buf_file_name(bufnr)
            end
        end

        M.buffers = buffers
        vim.opt.tabline = "%#TablineBackground#" .. left
    end)):send()
end

local function get_position()
    local bufnr = vim.api.nvim_win_get_buf(0) 
    local index
    for i, v in pairs(M.buffers) do
        if bufnr == v then
            index = i
            break
        end
    end

    return index
end

function M.next()
    local index = get_position()

    if index == #M.buffers then
        vim.api.nvim_win_set_buf(0, M.buffers[1])
    else
        vim.api.nvim_win_set_buf(0, M.buffers[index + 1])
    end
end

function M.prev()
    local index = get_position()

    if index == 1 then
        vim.api.nvim_win_set_buf(0, M.buffers[#M.buffers])
    else
        vim.api.nvim_win_set_buf(0, M.buffers[index - 1])
    end
end

function M.close()
    if bo.modified then
        cmd("write")
    end

    local bufnr = api.nvim_get_current_buf()

    local buffers = vim.tbl_filter(function(buf)
        return bo[buf].buflisted and api.nvim_buf_is_valid(buf)
    end, api.nvim_list_bufs())

    if #buffers == 1 then
        cmd("bd " .. bufnr)

        require("plugins.dashboard").instance()
    else
        if bufnr ~= buffers[#buffers] then
            cmd("bnext")
        else
            cmd("bprevious")
        end

        cmd("bd " .. bufnr)
    end
end

return M