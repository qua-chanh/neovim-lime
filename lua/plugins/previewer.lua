local api, fn = vim.api, vim.fn
local opt_local = vim.opt_local

local graphic = require('plugins.graphic')

local M = {}

function M.render()
    if settings.env.terminal == "xterm-kitty" then
        local bufnr = api.nvim_get_current_buf()

        vim.api.nvim_win_set_buf(api.nvim_get_current_win(), bufnr)

        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})

        opt_local.signcolumn = "no"
        opt_local.buftype = "nofile"
        opt_local.swapfile = false
        opt_local.spell = false
        opt_local.relativenumber = false
        opt_local.filetype = "png_previewer"
        opt_local.number = false
        opt_local.list = false
        opt_local.cursorline = false
        opt_local.cursorcolumn = false
        opt_local.matchpairs = ""
        opt_local.foldcolumn = "0"
        opt_local.colorcolumn = ""

        local image_id = graphic.transmit(api.nvim_buf_get_name(bufnr)) 
        graphic.move_cursor(10, 40)
        graphic.display({
            f = 100,
            c = 40,
            r = 20,
            i = image_id
        })
        graphic.restore_cursor()
    end
end

return M