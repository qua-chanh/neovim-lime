local M = {}

local highlight_const = require('nvim.highlights.const')

local NAMESPACE = vim.api.nvim_create_namespace(require('plugins.scrollbar.const').NAMESPACE)

function M.clear()
    vim.api.nvim_buf_clear_namespace(0, NAMESPACE, 0, -1)
end

function M.render()
    M.clear()

    local total_lines = vim.api.nvim_buf_line_count(0)
    local visible_lines = vim.api.nvim_win_get_height(0)
    local first_visible_line = vim.fn.line("w0")
    local last_visible_line = vim.fn.line("w$")

    if visible_lines >= total_lines then
        visible_lines = total_lines
    end

    local ratio = visible_lines / total_lines

    local relative_first_line = math.floor(first_visible_line * ratio) - math.floor(1 * ratio)
    local relative_last_line = math.floor(last_visible_line * ratio)

    local diff_last = 0
    local scroll_offset = visible_lines - (last_visible_line - first_visible_line) + diff_last

    for i = relative_first_line, relative_last_line, 1 do
        local mark_line = math.min(first_visible_line + i - scroll_offset, total_lines)

        if mark_line >= 0 then
            vim.api.nvim_buf_set_extmark(0, NAMESPACE, mark_line, -1, {
                virt_text_pos = "right_align",
                virt_text = {
                    { " ", "ScrollbarThumb" },
                }
            })
        end
    end
end

function M.setup()
    vim.api.nvim_set_hl(0, "ScrollbarThumb", { bg = highlight_const.comment })

    vim.api.nvim_create_autocmd({"BufWinEnter", "TabEnter", "WinEnter", "TextChanged", "VimResized", "WinScrolled", }, {
        group = vim.api.nvim_create_augroup("Scrollbar", {}),
        pattern = "*",
        callback = function()
            require('plugins.scrollbar').render()
        end,
    })

    vim.api.nvim_create_autocmd({"BufWinLeave", "TabLeave", "WinLeave" }, {
        group = vim.api.nvim_create_augroup("ScrollbarClear", {}),
        pattern = "*",
        callback = function()
            require('plugins.scrollbar').clear()
        end,
    })
end

return M