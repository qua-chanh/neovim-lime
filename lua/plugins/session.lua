local M = {}

local default_dir = "~/.local/share/nvim/sessions"

local function get_path(path)
  local git_branch = ""
  if vim.b.git_branch ~= "" then
    git_branch = ("-%s"):format(vim.b.git_branch)
  end

  return ("%s/%s%s.vim"):format(vim.fn.fnamemodify(path, ':p'), vim.fn.getcwd():gsub("/", "%%"), git_branch)
end

function M.write()
    local path = get_path(default_dir)

    local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h'):match("^.+/(.+)$")

    if dir ~= '.git' then
      vim.cmd(('mksession! %s'):format(vim.fn.fnameescape(path)))
    end

end

function M.read()
    local path = get_path(default_dir)

    local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h'):match("^.+/(.+)$")

    if dir ~= '.git' then
      vim.cmd(('silent! source %s'):format(vim.fn.fnameescape(path)))
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
