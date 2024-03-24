function _init()
    -- enable mouse
	poke(0x5f2d, 1)
    restart()
end

function _draw()
    cls()
    for i, v in pairs(entities) do
        v:draw()
    end
end

function _update()
    local mouse_x = stat(32)
    local mouse_y = stat(33)

    mouse:place(mouse_x, mouse_y)

	player:control(btn(0), btn(1), btn(2), btn(3))

    for i, v in pairs(entities) do
        v:update(time() - last)
    end

    last = time()
end

function restart()
    cls()
    local mouse_x = stat(32)
    local mouse_y = stat(33)

    last = time()
    mouse = entity:new()
    player = ship:new()
    entities = {
        mouse,
        player
    }
end