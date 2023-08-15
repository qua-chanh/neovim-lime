local M = {}

function M.load()
    vim.loop.new_async(vim.schedule_wrap(function()
        local left = ""

        local expand_tab = vim.api.nvim_get_option_value("expandtab", {buf = 0}) and "Spaces: " or "Tab Size: "
        local tab_stop = vim.api.nvim_get_option_value("tabstop", {buf = 0})

        local right = "Ln %l, Col %c   " .. expand_tab .. tab_stop .. "   " .. vim.bo.filetype:gsub("^%l", string.upper)
        vim.wo.statusline = "%#StatuslineBackground#  " .. left .. "%#StatuslineBackground#%=" .. right
    end)):send()
end

return M