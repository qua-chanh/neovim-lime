local const = require('nvim.highlights.const')

local base00 = const.base00
local base01 = const.base01
local base02 = const.base02
local base03 = const.base03
local base04 = const.base04
local base05 = const.base05
local base06 = const.base06
local base07 = const.base07
local base08 = const.base08
local base09 = const.base09
local base0A = const.base0A
local base0B = const.base0B
local base0C = const.base0C
local base0D = const.base0D
local base0E = const.base0E
local base0F = const.base0F
local background = const.background
local dark_background = const.dark_background
local cursorLine = const.cursorLine
local lineNumber = const.lineNumber
local comment = const.comment
local white = const.white

local nvim_set_hl = vim.api.nvim_set_hl

nvim_set_hl(0, "Cursor", { fg = base00 })
nvim_set_hl(0, "CursorLine", { bg = cursorLine })
nvim_set_hl(0, "CursorLineNr", { fg = base0A, bg = cursorLine })
nvim_set_hl(0, "LineNr", { fg = lineNumber, bg = background })
nvim_set_hl(0, "NonText", { fg = comment })
nvim_set_hl(0, "Normal", { bg = background })
nvim_set_hl(0, "SignColumn", { fg = base04, bg = background })
nvim_set_hl(0, "Visual", { bg = cursorLine })

nvim_set_hl(0, "TablineBackground", { fg = white, bg = dark_background })
nvim_set_hl(0, "WinbarBackground", { fg = comment, bg = background})
nvim_set_hl(0, "StatuslineBackground", { bg = dark_background })

nvim_set_hl(0, "@attribute", { fg = base0A })
nvim_set_hl(0, "@boolean", { fg = base09, italic = true })
nvim_set_hl(0, "@comment", { fg = base03, italic = true })
nvim_set_hl(0, "@constructor", { fg = base0C })
nvim_set_hl(0, "@conditional", { fg = base0E, italic = true })
nvim_set_hl(0, "@constant", { fg = base09, italic = true })
nvim_set_hl(0, "@constant.builtin", { fg = base0E })
nvim_set_hl(0, "@error", { fg = base08 })
nvim_set_hl(0, "@field", { fg = base08 })
nvim_set_hl(0, "@function", { fg = base0D })
nvim_set_hl(0, "@function.builtin", { fg = base0E, italic = true })
nvim_set_hl(0, "@keyword", { fg = base0E, italic = true })
nvim_set_hl(0, "@keyword.function", { fg = base0E, italic = true })
nvim_set_hl(0, "@keyword.operator", { fg = base0E, italic = true })
nvim_set_hl(0, "@label", { fg = base0E })
nvim_set_hl(0, "@method", { fg = base0D })
nvim_set_hl(0, "@namespace", { fg = base0E })
nvim_set_hl(0, "@namespace.builtin", { fg = base0E })
nvim_set_hl(0, "@number", { fg = base09, italic = true })
nvim_set_hl(0, "@operator", { fg = base0E })
nvim_set_hl(0, "@parameter", { fg = base08 })
nvim_set_hl(0, "@property", { fg = base0A })
nvim_set_hl(0, "@punctuation.delimiter", { fg = base0F })
nvim_set_hl(0, "@punctuation.bracket", { fg = base0C })
nvim_set_hl(0, "@repeat", { fg = base0E, italic = true })
nvim_set_hl(0, "@string", { fg = base0B })
nvim_set_hl(0, "@string.escape", { fg = base0C })
nvim_set_hl(0, "@variable", { fg = base08 })
nvim_set_hl(0, "@variable.builtin", { fg = base0E, italic = true })