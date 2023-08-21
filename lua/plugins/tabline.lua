local api, bo, cmd = vim.api, vim.bo, vim.cmd

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

local function get_position()
    return utils.index_of(Tabline.buffers, vim.api.nvim_win_get_buf(0))
end

function Tabline.load()
    vim.loop.new_async(vim.schedule_wrap(function()
        local left = ""
        local buffers = list_buffers()
        local cur_bufnr = api.nvim_get_current_buf()

        if buffers[1] == cur_bufnr then
            left = "▌"
        end

        for i, bufnr in pairs(buffers) do
            local icon = " "
            if i ~= 1 then
                if bufnr == cur_bufnr then
                    icon = "▌"
                else
                    icon = "|"
                end
            end

            left = ("%s%s  %s %s "):format(left, icon, vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':t'), save_icon(bufnr))  
        end

        Tabline.buffers = buffers
        vim.opt.tabline = "%#TablineBackground#" .. left
    end)):send()
end

function Tabline.next()
    api.nvim_win_set_buf(0, Tabline.buffers[math.fmod(get_position(), #Tabline.buffers) + 1])
end

function Tabline.prev()
    local index = get_position()

    if index == 1 then
        vim.api.nvim_win_set_buf(0, Tabline.buffers[#Tabline.buffers])
    else
        vim.api.nvim_win_set_buf(0, Tabline.buffers[index - 1])
    end
end

function Tabline.close()
    if bo.modified then
        cmd("write")
    end

    local bufnr = api.nvim_get_current_buf()

    if #Tabline.buffers == 1 then
        cmd(("bd %s"):format(bufnr))

        require("plugins.dashboard").instance()
    else
        if bufnr ~= Tabline.buffers[#Tabline.buffers] then
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
            Tabline.load()
        end,
    })
end

return Tabline
