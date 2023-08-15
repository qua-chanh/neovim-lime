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