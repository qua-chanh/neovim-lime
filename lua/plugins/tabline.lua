local M = {}

function M.load()
    vim.loop.new_async(vim.schedule_wrap(function()
        local left = ""
        for buffer = 1, vim.fn.bufnr('$') do
            local path = vim.api.nvim_buf_get_name(buffer)
            local file_name = path:match("^.+/(.+)$")

            left = left .. file_name
        end

        vim.opt.tabline = "%#TablineBackground#" .. left
    end)):send()
end

return M