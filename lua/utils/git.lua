local M = {}

function M.get_branch()
	return vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
end

return M