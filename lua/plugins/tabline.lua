local api, bo, cmd = vim.api, vim.bo, vim.cmd
local nvim_win_set_buf = api.nvim_win_set_buf

local utils = require("utils")

local Tabline = {}

Tabline.buffers = {}

local function list_buffers()
    return vim.tbl_filter(function(bufnr)
        return bo[bufnr].buflisted and api.nvim_buf_is_valid(bufnr)
    end, api.nvim_list_bufs())
end

local function save_icon(bufnr)
    if bo[bufnr].modified then
        return "⬤"
    else
        return "✕"
    end
end

function Tabline.render()
    vim.loop.new_async(vim.schedule_wrap(function()
        local left = ""
        local buffers = list_buffers()
        local cur_bufnr = api.nvim_get_current_buf()

        for i, bufnr in pairs(buffers) do
            local icon = " "
            if i ~= 1 then
                icon = "|"
            end

            if bufnr == cur_bufnr then
                icon = "▌"
            end

            left = ("%s%s  %s %s "):format(left, icon, vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':t'), save_icon(bufnr))  
        end

        Tabline.buffers = buffers
        vim.opt.tabline = "%#TablineBackground#" .. left
    end)):send()
end

function Tabline.close()
    if bo.modified then
        cmd("write")
    end

    local bufnr = api.nvim_get_current_buf()
    local len = #Tabline.buffers

    if len == 1 then
        cmd(("bd %s"):format(bufnr))

        require("plugins.dashboard").render()
    else
        if bufnr ~= Tabline.buffers[len] then
            cmd("bnext")
        else
            cmd("bprevious")
        end

        cmd(("bd %s"):format(bufnr))
    end
end

function Tabline.setup()
    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "Bufenter", "BufWritePost", "BufDelete", "BufWipeout", "BufLeave" }, {
        group = vim.api.nvim_create_augroup("Tabline", {}),
        pattern = "*",
        callback = function()
            Tabline.render()
        end,
    })
end

return Tabline
