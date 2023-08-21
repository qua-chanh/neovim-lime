local api, fn = vim.api, vim.fn
local opt_local = vim.opt_local
local M = {}
local graphic = require('plugins.graphic')

local dashboard_loaded = false

local default_banner = {
    "⠀⠀⠀⠀⠀⠀⠀⢀⣴⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣦⡀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣦⡀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣦⡀⠀⠀⠀",
    "⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣦⡀⠀",
    "⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣦",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⠻⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟",
    "⠀⠈⠻⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀",
    "⠀⠀⠀⠈⠻⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠈⠻⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠈⠻⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⠟⠁⠀⠀⠀⠀⠀⠀⠀",
}

local set_line_with_highlight = function(bufnr, tbl)
    api.nvim_buf_set_lines(bufnr, 1, #tbl, false, tbl)

    local dashboard_namespace = api.nvim_create_namespace("Dashboard")
    for i = 1, #tbl do
        api.nvim_buf_add_highlight(bufnr, dashboard_namespace, "DashboardHeader", i, 1, -1)
    end
end

local cache_header = {}
local image_id

function M.instance()
    local bufnr

    if vim.fn.line2byte("$") ~= -1 then
        vim.cmd("noautocmd")
        bufnr = api.nvim_create_buf(false, true)
    else
        bufnr = api.nvim_get_current_buf()
    end

    api.nvim_win_set_buf(api.nvim_get_current_win(), bufnr)

    opt_local.signcolumn = "no"
    opt_local.buftype = "nofile"
    opt_local.swapfile = false
    opt_local.spell = false
    opt_local.relativenumber = false
    opt_local.filetype = "dashboard"
    opt_local.number = false
    opt_local.list = false
    opt_local.cursorline = false
    opt_local.cursorcolumn = false
    opt_local.buflisted = false
    opt_local.matchpairs = ""
    opt_local.foldcolumn = "0"
    opt_local.colorcolumn = ""
    opt_local.bufhidden = "wipe"

    if settings.env.terminal == "xterm-kitty" then
        if not image_id then
            image_id = graphic.transmit("~/.config/nvim/assets/lime.png") 
        end

        graphic.move_cursor(10, 40)
        graphic.display({
            f = 100,
            c = 40,
            r = 20,
            i = image_id
        })
        graphic.restore_cursor()
    else
        if dashboard_loaded then
            set_line_with_highlight(bufnr, cache_header)
        else
            local render_header = coroutine.create(function(bufnr)
                local centered_lines = {}

                local top = math.floor((fn.winheight(0) - #default_banner) / 2)
                for _ = 1, top do
                    table.insert(centered_lines, "")
                end

                local width = math.floor((fn.winwidth(0) - fn.strwidth(default_banner[1])) / 2)
                local space = vim.fn["repeat"](" ", width)
                for i = 1, #default_banner do
                    table.insert(centered_lines, ("%s%s"):format(space, default_banner[i]))
                end

                cache_header = centered_lines
                set_line_with_highlight(bufnr, centered_lines)
            end)

            coroutine.resume(render_header, bufnr)
            dashboard_loaded = true
        end
    end

    local opts = { noremap = true, silent = true, nowait = true }
    api.nvim_buf_set_keymap(bufnr, "n", "h", "", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "l", "", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "w", "", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "b", "", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "<BS>", "", opts)
end

return M