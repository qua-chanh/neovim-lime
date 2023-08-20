local M = {}

local default_dir = "~/.local/share/nvim/sessions"

local function get_path(path)
    filename = vim.fn.getcwd():gsub("/", "%%")
    return vim.fn.fnamemodify(path, ':p') .. "/" .. filename .. ".vim"
end

function M.write()
    local path = get_path(default_dir)

    vim.cmd('mksession! ' .. vim.fn.fnameescape(path))
end

function M.read()
    local path = get_path(default_dir)

    local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h'):match("^.+/(.+)$")

    if dir ~= '.git' then
      vim.cmd('silent! source ' .. vim.fn.fnameescape(path))
    end
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
