local api, cmd, fn = vim.api, vim.cmd, vim.fn
local nvim_create_autocmd = api.nvim_create_autocmd

local utils = require('utils')

local Session = {}

local function get_path()
  local git_branch = ""
  local buf_git_branch = vim.b.git_branch
  if buf_git_branch ~= "" then
    git_branch = ("-%s"):format(buf_git_branch)
  end

  return fn.fnameescape(("%s/%s%s.vim"):format(settings.env.session_dir, fn.getcwd():gsub("/", "%%"), git_branch))
end

local function is_git()
  return utils.get_basename(fn.fnamemodify(api.nvim_buf_get_name(0), ':h')) == '.git'
end

Session.is_git = is_git()

function Session.write()
  if not Session.is_git then
    utils.create_not_exist_dir(settings.env.session_dir)

    cmd(('mksession! %s'):format((get_path())))
  end
end

function Session.read()
    if not Session.is_git then
      cmd(('silent! source %s'):format((get_path())))
    end
end

function Session.setup()
  local session_augroup = api.nvim_create_augroup("Session", {})

  nvim_create_autocmd({'VimLeavePre'}, {
    group = session_augroup,
    callback = function()
      Session.write()
    end
  })

  nvim_create_autocmd({'VimEnter'}, {
    group = session_augroup,
    nested = true,
    once = true,
    callback = function()
      Session.read()
    end,
  })
end

return Session
