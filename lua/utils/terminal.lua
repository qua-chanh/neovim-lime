local M = {}

function M.get_terminal()
    return vim.fn.system("echo $TERM 2> /dev/null | tr -d '\n'")
end

return M