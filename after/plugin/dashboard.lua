local api = vim.api
local utils = require("utils")

local autogroup = api.nvim_create_augroup("Dashboard", {})

api.nvim_create_autocmd("Vimenter", {
    group = autogroup,
    pattern = "*",
    nested = true,
    callback = function()
        if vim.fn.argc() == 0 and utils.is_empty_buf(0) then
            require("plugins.dashboard").render()
        end
    end,
})

-- api.nvim_create_autocmd({ "BufLeave" }, {
--     group = autogroup,
--     pattern = "*",
--     callback = function()
--         api.nvim_win_set_var(0, "dashboard_prev_pos", api.nvim_win_get_cursor(0))
--     end,
-- })

api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = autogroup,
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "dashboard" then
            return
        end
    end,
})