local nvim_create_autocmd = vim.api.nvim_create_autocmd

local Winbar = {
    group = vim.api.nvim_create_augroup("Winbar", {clear = false})
}

function Winbar.render()
    vim.uv.new_async(vim.schedule_wrap(function()
        local relative_path = string.gsub(vim.fn.expand("%"), "/", " > ")
        vim.wo.winbar = "%#WinbarBackground#  " .. relative_path
    end)):send()
end

function Winbar.setup()
    nvim_create_autocmd({ "Bufenter", "BufWritePost" }, {
        group = Winbar.group,
        pattern = "*",
        callback = function()
            Winbar.render()
        end,
    })
end

return Winbar