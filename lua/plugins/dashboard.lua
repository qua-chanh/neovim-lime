local api, fn, opt_local = vim.api, vim.fn, vim.opt_local
local nvim_buf_set_keymap = api.nvim_buf_set_keymap

local graphic = require('plugins.graphic')

local Dashboard = {
    loaded = false,
    text = {},
    namespace = api.nvim_create_namespace("Dashboard")
}

local function set_lines_highlight(bufnr)
    local len = #Dashboard.text
    api.nvim_buf_set_lines(bufnr, 1, len, false, Dashboard.text)

    for i = 1, len do
        api.nvim_buf_add_highlight(bufnr, Dashboard.namespace, "DashboardText", i, 1, -1)
    end
end

local function set_local_opts()
    opt_local.bufhidden = "wipe"
    opt_local.buflisted = false
    opt_local.buftype = "nofile"
    opt_local.colorcolumn = ""
    opt_local.cursorcolumn = false
    opt_local.cursorline = false
    opt_local.filetype = "dashboard"
    opt_local.foldcolumn = "0"
    opt_local.list = false
    opt_local.matchpairs = ""
    opt_local.number = false
    opt_local.relativenumber = false
    opt_local.signcolumn = "no"
    opt_local.spell = false
    opt_local.swapfile = false
end

local function set_keymaps(bufnr)
    local opts = { noremap = true, silent = true, nowait = true }
    nvim_buf_set_keymap(bufnr, "n", "h", "", opts)
    nvim_buf_set_keymap(bufnr, "n", "l", "", opts)
    nvim_buf_set_keymap(bufnr, "n", "w", "", opts)
    nvim_buf_set_keymap(bufnr, "n", "b", "", opts)
    nvim_buf_set_keymap(bufnr, "n", "<BS>", "", opts)
end

local function center_dashboard_text()
    local dashboard_text = settings.env.dashboard_text
    local len = #dashboard_text

    local top = math.floor((fn.winheight(0) - len) / 2)
    for _ = 1, top do
        table.insert(Dashboard.text, "")
    end

    local space = vim.fn["repeat"](" ", math.floor((fn.winwidth(0) - fn.strwidth(dashboard_text[1])) / 2))
    for i = 1, len do
        table.insert(Dashboard.text, ("%s%s"):format(space, dashboard_text[i]))
    end
end

function Dashboard.render()
    local bufnr = api.nvim_get_current_buf()

    api.nvim_win_set_buf(api.nvim_get_current_win(), bufnr)

    set_local_opts()

    if settings.env.terminal == "xterm-kitty" then
        if not Dashboard.image_id then
            Dashboard.image_id = graphic.transmit(settings.env.dashboard_image) 
        end

        graphic.move_cursor(10, 40)
        graphic.display({
            f = 100,
            c = 40,
            r = 20,
            i = Dashboard.image_id
        })
        graphic.restore_cursor()
    else
        if Dashboard.loaded then
            set_lines_highlight(bufnr)
        else
            coroutine.resume(coroutine.create(function(bufnr)
                center_dashboard_text()
                set_lines_highlight(bufnr)
            end), bufnr)

            Dashboard.loaded = true
        end
    end

    set_keymaps(bufnr)
end

return Dashboard