local M = {}

function M.load()
    vim.loop.new_async(vim.schedule_wrap(function()
        local relative_path = string.gsub(vim.fn.expand("%"), "/", " > ")
        vim.wo.winbar = "%#WinbarBackground#  " .. relative_path
    end)):send()
end

return M