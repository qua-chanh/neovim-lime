local bo = vim.bo

local Statusline = {}

function Statusline.render()
    vim.uv.new_async(vim.schedule_wrap(function()
        local left = " " .. vim.b.git_branch

        local expand_tab = bo.expandtab and "Spaces: " or "Tab Size: "
        local tab_stop = bo.tabstop

        local right = "Ln %l, Col %c   " .. expand_tab .. tab_stop .. "   " .. bo.filetype:gsub("^%l", string.upper)
        vim.wo.statusline = "%#StatuslineBackground#  " .. left .. "%#StatuslineBackground#%=" .. right .. "  🍋  "
    end)):send()
end

function Statusline.setup()
    vim.api.nvim_create_autocmd({ "Bufenter", "BufWritePost" }, {
        group = vim.api.nvim_create_augroup("StatusLine", {}),
        pattern = "*",
        callback = function()
            Statusline.render()
        end,
    })
end

return Statusline