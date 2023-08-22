local Winbar = {}

function Winbar.render()
    vim.loop.new_async(vim.schedule_wrap(function()
        local relative_path = string.gsub(vim.fn.expand("%"), "/", " > ")
        vim.wo.winbar = "%#WinbarBackground#  " .. relative_path
    end)):send()
end

function Winbar.setup()
    vim.api.nvim_create_autocmd({ "Bufenter", "BufWritePost" }, {
        group = vim.api.nvim_create_augroup("Winbar", {}),
        pattern = "*",
        callback = function()
            Winbar.render()
        end,
    })
end

return Winbar