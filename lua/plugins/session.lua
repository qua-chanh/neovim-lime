local M = {}

local function get_path()
    vim.fn.resolve(vim.fn.fnamemodify(vim.fn.getcwd(), ':p'))
end

function M.write()
    local path = get_path()

    vim.cmd('mksession! ' .. vim.fn.fnameescape(path))
end

function M.read()
    local path = get_path()

    vim.cmd('silent! source ' .. vim.fn.fnameescape(path))
end

function M.setup()
    vim.api.nvim_create_autocmd(
      'VimLeavePre',
      { group = augroup, callback = function()
      M.write()
    end, desc = 'Autowrite current session' }
    )

    vim.api.nvim_create_autocmd(
      'VimEnter',
      { group = augroup, nested = true, once = true, callback = function()
      M.read()
    end, desc = 'Autoread latest session' }
    )
end

return M
