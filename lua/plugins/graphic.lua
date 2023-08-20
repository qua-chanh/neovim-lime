local stdout = vim.loop.new_tty(1, false)

local M = {}

M.index = 1
M.images = {}
M.show_images = {}
M.image_path = {}

local function get_chunked(str)
    local chunks = {}
    for i = 1,#str,4096 do
        local chunk = str:sub(i, i + 4096 - 1):gsub('%s', '')
        if #chunk > 0 then
            table.insert(chunks, chunk)
        end
    end

    return chunks
end

local function send(ctrl, payload)
    if payload then
        M.write(('\x1b_G%s;%s\x1b\\'):format(ctrl, payload))
    else
        M.write(('\x1b_G%s\x1b\\'):format(ctrl))
    end
end

function M.transmit(path)
    local is_new = true
    local id = M.index

    if M.image_path[path] then
        is_new = false
        id = M.image_path[path]
    end

    local payload = vim.fn.system(("base64 -w 0 %s"):format(path))
    local ctrl = ("f=100,i=%s"):format(id)
    if payload and string.len(payload) > 4096 then
        ctrl = ("%s,m=1"):format(ctrl)
    else
        ctrl = ("%s,m=0"):format(ctrl)
    end

    payload = get_chunked(payload)

    for i=1,#payload do
        send(ctrl, payload[i])
        if i == #payload-1 then
            ctrl = 'm=0'
        else
            ctrl = 'm=1'
        end
    end

    if is_new then
        table.insert(M.images, id) 
        M.image_path[path] = id
        M.index = id + 1
    end

    return id
end

function M.display(keys)
    if keys.i == nil then
        return
    end

    if not vim.list_contains(M.images, keys.i) then
        return
    end

    keys.a = "p"

    local ctrl = ''
    for k, v in pairs(keys) do
        if v ~= nil then
            ctrl = ctrl..k..'='..v..','
        end
    end

    ctrl = ctrl:sub(0, -2)
    send(ctrl)

    table.insert(M.show_images, keys.i) 
	vim.b.has_graphic = true
end

function M.delete_all()
    for _, v in pairs(M.show_images) do
        send(('a=d,i=%s'):format(v))
    end

    M.show_images = {}

	vim.b.has_graphic = false
end

function M.move_cursor(row, col)
    M.write('\x1b[s')
    M.write('\x1b['..row..':'..col..'H')
end

function M.restore_cursor()
    M.write('\x1b[u')
end

M.write = vim.schedule_wrap(function(data)
    stdout:write(data)
end)

return M