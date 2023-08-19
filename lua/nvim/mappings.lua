local set = vim.keymap.set

vim.g.mapleader = " "

set("i", "jk", "<Esc>", {noremap = true})

set("n", "<Leader>s", [[:silent write<CR>]], {noremap = true, silent = true})
set({"n", "v"}, "<Leader>/", [[:CommentToggle<CR>]], {noremap = true, silent = true})
set("n", "]b", require('plugins.tabline').next, {noremap = true, silent = true})
set("n", "[b", require('plugins.tabline').prev, {noremap = true, silent = true})
set("n", "<Leader>w", require("plugins.tabline").close, {noremap = true, silent = true})