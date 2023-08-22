local stdout = vim.loop.new_tty(1, false)

local Graphic = {
    index = 1,
    show_images = {},
    image_paths = {},
    write = vim.schedule_wrap(function(data)
        stdout:write(data)
    end)
}

local function is_exist(image_id)
    return vim.tbl_contains(Graphic.image_paths, function(_, v)
        return v == image_id
    end)
end

local function get_chunks(str)
    local chunks = {}
    for i = 1, #str, 4096 do
        local chunk = str:sub(i, i + 4096 - 1):gsub('%s', '')
        if #chunk > 0 then
            table.insert(chunks, chunk)
        end
    end

    return chunks
end

local function send(ctrl, payload)
    if payload then
        Graphic.write(('\x1b_G%s;%s\x1b\\'):format(ctrl, payload))
    else
        Graphic.write(('\x1b_G%s\x1b\\'):format(ctrl))
    end
end

function Graphic.transmit(path)
    local is_new = true
    local id = Graphic.index

    if Graphic.image_paths[path] then
        is_new = false
        id = Graphic.image_paths[path]
    end

    local payload = vim.fn.system(("base64 -w 0 %s"):format(path))
    local ctrl = ("f=100,i=%s"):format(id)
    if payload and string.len(payload) > 4096 then
        ctrl = ("%s,m=1"):format(ctrl)
    else
        ctrl = ("%s,m=0"):format(ctrl)
    end

    local chunks = get_chunks(payload)
    local len = #chunks
    for i = 1, len do
        send(ctrl, chunks[i])
        if i == len - 1 then
            ctrl = 'm=0'
        else
            ctrl = 'm=1'
        end
    end

    if is_new then
        Graphic.image_paths[path] = id
        Graphic.index = id + 1
    end

    return id
end

function Graphic.display(keys)
    if not keys.i then
        return
    end

    if not is_exist(keys.i) then
        return
    end

    local ctrl = 'a=p,'
    for k, v in pairs(keys) do
        if v ~= nil then
            ctrl = ("%s%s=%s,"):format(ctrl, k, v)
        end
    end

    ctrl = ctrl:sub(0, -2)
    send(ctrl)

    table.insert(Graphic.show_images, keys.i) 
	vim.b.has_graphic = true
end

function Graphic.delete_all()
    for _, v in pairs(Graphic.show_images) do
        send(('a=d,i=%s'):format(v))
    end

    Graphic.show_images = {}
	vim.b.has_graphic = false
end

function Graphic.move_cursor(row, col)
    Graphic.write('\x1b[s')
    Graphic.write(('\x1b[%s:%sH'):format(row, col))
end

function Graphic.restore_cursor()
    Graphic.write('\x1b[u')
end

function Graphic.setup()
    vim.api.nvim_create_autocmd({"BufDelete", "BufWipeout", "BufLeave" }, {
        callback = function()
            if vim.b.has_graphic then
                Graphic.delete_all()
            end
        end
    })
end

return Graphic