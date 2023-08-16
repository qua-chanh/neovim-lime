local M = {}

function M.load()
    vim.loop.new_async(vim.schedule_wrap(function()
        local left = ""

        local expand_tab = vim.bo.expandtab and "Spaces: " or "Tab Size: "
        local tab_stop = vim.bo.tabstop

        local right = "Ln %l, Col %c   " .. expand_tab .. tab_stop .. "   " .. vim.bo.filetype:gsub("^%l", string.upper)
        vim.wo.statusline = "%#StatuslineBackground#  " .. left .. "%#StatuslineBackground#%=" .. right
    end)):send()
end

return M