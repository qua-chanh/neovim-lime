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
local cursor_line = "#2C313A"
local line_number = "#495162"
local comment = "#5C6370"
local white = "#FFFFFF"

return {
    ["Cursor"] = { fg = base00 },
    ["CursorLine"] = { bg = cursor_line },
    ["CursorLineNr"] = { fg = base0A, bg = cursor_line },
    ["LineNr"] = { fg = line_number, bg = background },
    ["NonText"] = { fg = comment },
    ["Normal"] = { bg = background },
    ["SignColumn"] = { fg = base04, bg = background },
    ["Visual"] = { bg = cursor_line },

    ["TablineBackground"] = { fg = white, bg = dark_background },
    ["WinbarBackground"] = { fg = comment, bg = background},
    ["StatuslineBackground"] = { bg = dark_background },

    ["@attribute"] = { fg = base0A },
    ["@boolean"] = { fg = base09, italic = true },
    ["@comment"] = { fg = base03, italic = true },
    ["@constructor"] = { fg = base0C },
    ["@conditional"] = { fg = base0E, italic = true },
    ["@constant"] = { fg = base09, italic = true },
    ["@constant.builtin"] = { fg = base0E },
    ["@error"] = { fg = base08 },
    ["@field"] = { fg = base08 },
    ["@function"] = { fg = base0D },
    ["@function.builtin"] = { fg = base0E, italic = true },
    ["@keyword"] = { fg = base0E, italic = true },
    ["@keyword.function"] = { fg = base0E, italic = true },
    ["@keyword.operator"] = { fg = base0E, italic = true },
    ["@label"] = { fg = base0E },
    ["@method"] = { fg = base0D },
    ["@namespace"] = { fg = base0E },
    ["@namespace.builtin"] = { fg = base0E },
    ["@number"] = { fg = base09, italic = true },
    ["@operator"] = { fg = base0E },
    ["@parameter"] = { fg = base08 },
    ["@property"] = { fg = base0A },
    ["@punctuation.delimiter"] = { fg = base0F },
    ["@punctuation.bracket"] = { fg = base0C },
    ["@repeat"] = { fg = base0E, italic = true },
    ["@string"] = { fg = base0B },
    ["@string.escape"] = { fg = base0C },
    ["@variable"] = { fg = base08 },
    ["@variable.builtin"] = { fg = base0E, italic = true },

    ["ScrollbarThumb"] = { bg = comment }
}