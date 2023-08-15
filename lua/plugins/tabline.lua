local utils = require("utils")

local M = {}

function M.load()
    vim.loop.new_async(vim.schedule_wrap(function()
        local left = ""
        for bufnr = 1, vim.fn.bufnr('$') do
            if not utils.is_empty_buf(bufnr) then 
                left = left .. utils.get_buf_file_name(bufnr)
            end
        end

        vim.opt.tabline = "%#TablineBackground#" .. left
    end)):send()
end

return M