local stdout = vim.loop.new_tty(1, false)

local Notify = {
  id = 0
}

function Notify.send(message, level, opts)
  stdout:write(('\x1b]99;i=%s:d=0;%s\x1b\\'):format(M.id, level))
  stdout:write(('\x1b]99;i=%s:d=1:p=body;%s\x1b\\'):format(M.id, message))

  Notify.id = Notify.id + 1
end

function Notify.__call(_, message, level, opts)
  if vim.in_fast_event() then
    vim.schedule(function()
      Notify.send(message, level, opts)
    end)
  else
    return Notify.send(message, level, opts)
  end
end

function Notify.setup()
  if settings.env.terminal == "xterm-kitty" then
    vim.notify = Notify
  end
end

return Notify