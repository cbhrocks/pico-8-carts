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

    mouse:move(mouse_x, mouse_y)
end

function restart()
    cls()
    local mouse_x = stat(32)
    local mouse_y = stat(33)

    mouse = entity:new()
    ship = ship:new()
    entities = {
        mouse,
        ship
    }
end