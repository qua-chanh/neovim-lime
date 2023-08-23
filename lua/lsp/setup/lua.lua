local nvim_buf_set_keymap = vim.api.nvim_buf_set_keymap

local Lua = {}

function Lua.setup()
    return vim.lsp.start_client {
        name = 'lua-language-server',
        cmd = {settings.lsp.lua.cmd},
        root_dir = vim.fs.dirname(vim.fs.find({'lua'}, { upward = true })[1]),
        on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true }
            nvim_buf_set_keymap(bufnr, "n", "[d", ":lua vim.diagnostic.goto_prev()<CR>", opts)
            nvim_buf_set_keymap(bufnr, "n", "]d", ":lua vim.diagnostic.goto_next()<CR>", opts)
            nvim_buf_set_keymap(bufnr, "n", "<Leader>d", ":lua vim.lsp.buf.definition()<CR>", opts)
            nvim_buf_set_keymap(bufnr, "n", "<Leader>a", ":lua vim.lsp.buf.code_action()<CR>", opts)
            
            client.server_capabilities.semanticTokensProvider = nil
        end,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },

                diagnostics = {
                    globals = { "vim" },
                },

                workspace = {
                    maxPreload = 2000,
                    preloadFileSize = 150,
                    library = vim.api.nvim_get_runtime_file("", true),
                },

                telemetry = {
                    enable = false
                }
            },
        },
    }
end

return Lua