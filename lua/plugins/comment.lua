local api = vim.api
local M = {}

local function get_indent(line)
    return line:match('^%s+') or ''
end

local function is_empty(line)
    return line:match('^%s*$')
end

function M.toggle(line_start, line_end)
    local comment_string = api.nvim_get_option_value("commentstring", {buf = 0})
    if not comment_string:match('%%s') then
        return
    end

    local left_comment, right_comment = comment_string:match('^(.*)%%s(.*)')
    local escape_left_comment = vim.pesc(left_comment)

    local is_commented
    local indent

    local lines = api.nvim_buf_get_lines(0, line_start - 1, line_end, false)

    for _, line in pairs(lines) do
        -- Check data is commented
        if not is_commented and line:find('^%s*' .. escape_left_comment) then
            is_commented = true
        end

        -- Find smallest indent
        local line_indent = get_indent(line)
        if not indent or string.len(line_indent) < string.len(indent) then
            indent = line_indent
        end
    end

    if is_commented then
        for i, v in pairs(lines) do
            local line = v
            -- Remove right comment
            if right_comment then
                line = line:gsub(vim.pesc(right_comment) .. '$', '')
            end

            -- Remove left comment
            lines[i] = line:gsub(escape_left_comment, '', 1)
        end
    else
        for i, v in pairs(lines) do
            if not is_empty(v) then
                -- Remove indent
                local line = v:gsub('^' .. indent, '')

                -- Add right comment
                if right_comment then
                    line = line .. right_comment
                end

                -- Add indent and left comment
                lines[i] = indent .. left_comment .. line
            end
        end
    end

    api.nvim_buf_set_lines(0, line_start - 1, line_end, false, lines)
end

return M
