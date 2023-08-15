vim.api.nvim_command("command! -range CommentToggle lua require('plugins.comment').toggle(<line1>, <line2>)")

vim.api.nvim_create_autocmd( 'FileType', { pattern = 'lua',
  callback = function(args)
    vim.treesitter.start(args.buf, 'lua')
  end
})

vim.api.nvim_create_autocmd({ "Bufenter", "BufWritePost" }, {
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