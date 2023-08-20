local stdout = vim.loop.new_tty(1, false)

local M = {}

M.id = 0

function M.send(message, level, opts)
    stdout:write(('\x1b]99;i=%s:d=0;%s\x1b\\'):format(M.id, level))
    stdout:write(('\x1b]99;i=%s:d=1:p=body;%s\x1b\\'):format(M.id, message))

    M.id = M.id + 1
end

setmetatable(M, {
  __call = function(_, m, l, o)
    if vim.in_fast_event() then
      vim.schedule(function()
        M.send(m, l, o)
      end)
    else
      return M.send(m, l, o)
    end
  end,
})

function M.setup()
    if settings.terminal == "xterm-kitty" then
        vim.notify = require('plugins.notify')
    end
end

return M