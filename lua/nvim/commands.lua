vim.api.nvim_create_autocmd( 'FileType', { pattern = 'lua',
  callback = function(args)
    vim.treesitter.start(args.buf, 'lua')
  end
})

vim.api.nvim_create_autocmd({ "Bufenter", "BufWritePost", "BufDelete", "BufWipeout", "BufLeave" }, {
    group = vim.api.nvim_create_augroup("Tabline", {}),
    pattern = "*",
    callback = function()
        require('plugins.tabline').load()
    end,
})

vim.api.nvim_create_autocmd({ "Bufenter", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("Winbar", {}),
    pattern = "*",
    callback = function()
        require('plugins.winbar').load()
    end,
})

vim.api.nvim_create_autocmd({ "Bufenter", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("StatusLine", {}),
    pattern = "*",
    callback = function()
        require('plugins.statusline').load()
    end,
})

vim.api.nvim_create_autocmd({"FileType", "BufEnter", "FocusGained"}, {
	callback = function()
		vim.b.git_branch = require('utils.git').get_branch()
	end
})

vim.api.nvim_create_autocmd({"BufDelete", "BufWipeout", "BufLeave" }, {
    callback = function()
        if vim.b.has_graphic then
            require('plugins.graphic').delete_all()
        end
    end,
})

vim.api.nvim_create_autocmd( {'BufNewFile', 'BufRead'}, { pattern = '*.png',
  callback = function(args)
    require('plugins.previewer').render()
  end
})