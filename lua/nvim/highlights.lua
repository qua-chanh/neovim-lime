local nvim_set_hl = vim.api.nvim_set_hl

for k, v in pairs(settings.highlights) do
    nvim_set_hl(0, k, v)
end