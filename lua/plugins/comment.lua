local api = vim.api
local M = {}

local function get_indent(line)
    return line:match('^%s+') or ''
end

local function is_empty(line)
    return line:match('^%s*$')
end

local function is_valid_comment_string(comment_string)
    return comment_string:match('%%s')
end

local function is_commented(line, left_comment)
    return line:find('^%s*' .. vim.pesc(left_comment))
end

local function get_comment()
    local comment_string = vim.bo.commentstring
    if not is_valid_comment_string(comment_string) then
        return
    end

    return comment_string:match('^(.*)%%s(.*)')
end

local function get_min_indent(lines)
    local min_indent
    for _, line in pairs(lines) do
        local line_indent = get_indent(line)
        if not min_indent or string.len(line_indent) < string.len(min_indent) then
            min_indent = line_indent
        end
    end

    return min_indent
end

function M.uncomment(line_start, line_end)
    local left_comment, right_comment = get_comment()
    local lines = api.nvim_buf_get_lines(0, line_start - 1, line_end, false)

    for i, v in pairs(lines) do
        local line = v
        -- Remove right comment
        if right_comment then
            line = line:gsub(vim.pesc(right_comment) .. '$', '')
        end

        -- Remove left comment
        lines[i] = line:gsub(vim.pesc(left_comment), '', 1)
    end

    api.nvim_buf_set_lines(0, line_start - 1, line_end, false, lines)
end

function M.comment(line_start, line_end)
    local left_comment, right_comment = get_comment()
    local lines = api.nvim_buf_get_lines(0, line_start - 1, line_end, false)

    local indent = get_min_indent(lines)
    for i, v in pairs(lines) do
        if not is_empty(v) then
            -- Remove indent
            local line = v:gsub(('^%s'):format(indent), '')

            -- Add right comment
            if right_comment then
                line = ("%s%s"):format(line, right_comment)
            end

            -- Add indent and left comment
            lines[i] = ("%s%s%s"):format(indent, left_comment, line)
        end
    end

    api.nvim_buf_set_lines(0, line_start - 1, line_end, false, lines)
end

function M.toggle(line_start, line_end)
    local left_comment, _ = get_comment()
    local line = api.nvim_buf_get_lines(0, line_start - 1, line_start, false)[1]

    if is_commented(line, left_comment) then
        M.uncomment(line_start, line_end)
    else
        M.comment(line_start, line_end)
    end
end

return M
