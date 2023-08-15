----------
--
-- Options
--
----------
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 0
vim.opt.cursorline = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.foldenable = false
-- opt.foldexpr = "treesitter#fold()"
vim.opt.foldmethod = "expr"
-- opt.indentexpr = "treesitter#indent()"
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = [[tab:\ ,trail:-,eol:↵]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.scrolloff = 18
vim.opt.shortmess = "atOIc"
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.updatetime = 300

require("treesitter")

----------
--
-- Mappings
--
----------
vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<Esc>", {noremap = true})

vim.keymap.set("n", "<Leader>s", [[:silent write<CR>]], {noremap = true, silent = true})
vim.keymap.set("n", "<Leader>/", [[:CommentToggle<CR>]], {noremap = true, silent = true})
vim.keymap.set("v", "<Leader>/", [[:CommentToggle<CR>]], {noremap = true, silent = true})

----------
--
-- commands
--
----------
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

----------
--
-- Highlights
--
----------
local base00 = "#282c34"
local base01 = "#353b45"
local base02 = "#3e4451"
local base03 = "#545862"
local base04 = "#565c64"
local base05 = "#abb2bf"
local base06 = '#b6bdca'
local base07 = "#c8ccd4"
local base08 = "#F9867B"
local base09 = "#CD9731"
local base0A = "#FDCE68"
local base0B = "#A3EEA0"
local base0C = "#6796E6"
local base0D = "#7BE2F9"
local base0E = "#E19EF5"
local base0F = "#F44747"
local background = "#212835"
local dark_background = "#1B212C"
local cursorLine = "#2C313A"
local lineNumber = "#495162"
local comment = "#5C6370"
local white = "#FFFFFF"

vim.api.nvim_set_hl(0, "Cursor", { fg = base00 })
vim.api.nvim_set_hl(0, "CursorLine", { bg = cursorLine })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = base0A, bg = cursorLine })
vim.api.nvim_set_hl(0, "LineNr", { fg = lineNumber, bg = background })
vim.api.nvim_set_hl(0, "NonText", { fg = comment })
vim.api.nvim_set_hl(0, "Normal", { bg = background })
vim.api.nvim_set_hl(0, "SignColumn", { fg = base04, bg = background })
vim.api.nvim_set_hl(0, "Visual", { bg = cursorLine })

vim.api.nvim_set_hl(0, "TablineBackground", { fg = white, bg = dark_background })
vim.api.nvim_set_hl(0, "WinbarBackground", { fg = comment, bg = background})
vim.api.nvim_set_hl(0, "StatuslineBackground", { bg = dark_background })

vim.api.nvim_set_hl(0, "TSAnnotation", { fg = base0A })
vim.api.nvim_set_hl(0, "@attribute", { fg = base0A })
vim.api.nvim_set_hl(0, "@boolean", { fg = base09, italic = true })
vim.api.nvim_set_hl(0, "@character", { fg = base0C })
vim.api.nvim_set_hl(0, "@comment", { fg = base03, italic = true })
vim.api.nvim_set_hl(0, "@constructor", { fg = base0C })
vim.api.nvim_set_hl(0, "@conditional", { fg = base0E, italic = true })
vim.api.nvim_set_hl(0, "@constant", { fg = base09, italic = true })
vim.api.nvim_set_hl(0, "@constant.builtin", { fg = base0E })
vim.api.nvim_set_hl(0, "@constant.macro", { fg = base0E })
vim.api.nvim_set_hl(0, "@error", { fg = base08 })
vim.api.nvim_set_hl(0, "@exception", { fg = base0E })
vim.api.nvim_set_hl(0, "@field", { fg = base08 })
vim.api.nvim_set_hl(0, "@float", { fg = base09, italic = true })
vim.api.nvim_set_hl(0, "@function", { fg = base0D })
vim.api.nvim_set_hl(0, "@function.builtin", { fg = base0E, italic = true })
vim.api.nvim_set_hl(0, "@function.macro", { fg = base0D })
vim.api.nvim_set_hl(0, "@include", { fg = base0D })
vim.api.nvim_set_hl(0, "@keyword", { fg = base0E, italic = true })
vim.api.nvim_set_hl(0, "@keyword.function", { fg = base0E, italic = true })
vim.api.nvim_set_hl(0, "@keyword.operator", { fg = base0E, italic = true })
vim.api.nvim_set_hl(0, "@label", { fg = base0E })
vim.api.nvim_set_hl(0, "@method", { fg = base0D })
vim.api.nvim_set_hl(0, "@namespace", { fg = base0E })
vim.api.nvim_set_hl(0, "@none", { fg = base0E })
vim.api.nvim_set_hl(0, "@number", { fg = base09, italic = true })
vim.api.nvim_set_hl(0, "@operator", { fg = base0E })
vim.api.nvim_set_hl(0, "@parameter", { fg = base08 })
vim.api.nvim_set_hl(0, "TSParameterReference", { fg = base08 })
vim.api.nvim_set_hl(0, "@property", { fg = base0A })
vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = base0F })
vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = base0C })
vim.api.nvim_set_hl(0, "@punctuation.special", { fg = base0F })
vim.api.nvim_set_hl(0, "@repeat", { fg = base0E, italic = true })
vim.api.nvim_set_hl(0, "@string", { fg = base0B })
vim.api.nvim_set_hl(0, "@string.regex", { fg = base0B })
vim.api.nvim_set_hl(0, "@string.escape", { fg = base0C })
vim.api.nvim_set_hl(0, "@string.special", { fg = base0B })
vim.api.nvim_set_hl(0, "@symbol", { fg = base0B })
vim.api.nvim_set_hl(0, "@tag", { fg = base0A })
vim.api.nvim_set_hl(0, "@tag.attribute", { fg = base0A })
vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = base0F })
vim.api.nvim_set_hl(0, "@text", { fg = base08 })
vim.api.nvim_set_hl(0, "@text.strong", { bold = true })
vim.api.nvim_set_hl(0, "@text.emphasis", { fg = base09, italic = true })
vim.api.nvim_set_hl(0, "@text.underline", { fg = base00, underline = true })
vim.api.nvim_set_hl(0, "@text.strike", { fg = base00, strikethrough = true })
vim.api.nvim_set_hl(0, "@text.title", { fg = base0D })
vim.api.nvim_set_hl(0, "@text.literal", { fg = base09 })
vim.api.nvim_set_hl(0, "@text.uri", { fg = base09, underline = true })
vim.api.nvim_set_hl(0, "TSMath", { fg = base0E })
vim.api.nvim_set_hl(0, "@type", { fg = base0A, italic = true })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = base0E })
vim.api.nvim_set_hl(0, "@variable", { fg = base08 })
vim.api.nvim_set_hl(0, "@variable.builtin", { fg = base0E, italic = true })
