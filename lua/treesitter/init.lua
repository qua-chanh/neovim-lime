vim.treesitter.language.add('lua', { path = ("%s%s"):format(vim.fn.stdpath("config"), "/lua/treesitter/parsers/lua.so")})

vim.api.nvim_create_autocmd( 'FileType', { pattern = 'lua',
    callback = function(args)
        vim.treesitter.start(args.buf, 'lua')
    end
})