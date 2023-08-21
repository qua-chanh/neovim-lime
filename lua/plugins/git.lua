local Git = {}

function Git.setup()
    vim.api.nvim_create_autocmd({"VimEnter", "FileType", "BufEnter", "FocusGained"}, {
	    callback = function()
		    vim.b.git_branch = require('utils.git').get_branch()
	    end
    })
end

return Git