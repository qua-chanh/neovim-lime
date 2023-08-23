local api = vim.api
local nvim_create_autocmd = vim.api.nvim_create_autocmd

local LSP = {
    group = api.nvim_create_augroup("LSP", {clear = false}),
    clients = {}
}

function LSP.setup()
    nvim_create_autocmd({"FileType"}, {
        group = LSP.group,
        pattern = "lua",
        callback = function(opt)
            local client_id = LSP.clients["lua"]
            if client_id then
                vim.lsp.buf_attach_client(opt.buf, client_id)
            else
                client_id = require('lsp.setup.lua').setup()
                vim.lsp.buf_attach_client(opt.buf, client_id)
                LSP.clients["lua"] = client_id
            end
        end,
    })
end

return LSP