local api, fn = vim.api, vim.fn
local nvim_create_autocmd, nvim_create_augroup = api.nvim_create_autocmd, api.nvim_create_augroup

local Scrollbar = {
    namespace = api.nvim_create_namespace("Scrollbar")
}

function Scrollbar.clear()
    api.nvim_buf_clear_namespace(0, Scrollbar.namespace, 0, -1)
end

function Scrollbar.render()
    Scrollbar.clear()

    local total_lines = api.nvim_buf_line_count(0)
    local visible_lines = api.nvim_win_get_height(0)
    local first_visible_line = fn.line("w0")
    local last_visible_line = fn.line("w$")

    if visible_lines >= total_lines then
        visible_lines = total_lines
    end

    local ratio = visible_lines / total_lines

    local relative_first_line = math.floor(first_visible_line * ratio) - math.floor(1 * ratio)
    local relative_last_line = math.floor(last_visible_line * ratio)

    local scroll_offset = visible_lines - (last_visible_line - first_visible_line)

    for i = relative_first_line, relative_last_line, 1 do
        local mark_line = math.min(first_visible_line + i - scroll_offset, total_lines)
        if mark_line >= 0 then
            api.nvim_buf_set_extmark(0, Scrollbar.namespace, mark_line, -1, {
                virt_text_pos = "right_align",
                virt_text = {
                    { " ", "ScrollbarThumb" },
                }
            })
        end
    end
end

function Scrollbar.setup()
    nvim_create_autocmd({"BufWinEnter", "TabEnter", "WinEnter", "TextChanged", "VimResized", "WinScrolled", }, {
        group = nvim_create_augroup("Scrollbar", {}),
        pattern = "*",
        callback = function()
            Scrollbar.render()
        end,
    })

    nvim_create_autocmd({"BufWinLeave", "TabLeave", "WinLeave" }, {
        group = nvim_create_augroup("ScrollbarClear", {}),
        pattern = "*",
        callback = function()
            Scrollbar.clear()
        end,
    })
end

return Scrollbar
