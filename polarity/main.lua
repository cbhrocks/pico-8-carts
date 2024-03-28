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

	player:control(btn(0), btn(1), btn(2), btn(3))

    for i, v in pairs(entities) do
        v:update(time() - last)
    end

    queue.pushright(ship_locs, {x = player.x - 63, y = player.y - 63})
    if (ship_locs.last - ship_locs.first > 20) then
        local loc = queue.popleft(ship_locs)
        camera(loc.x, loc.y)
    end

    if (flr(time()) == next_m) then
        spawn_meteor(player)
        next_m += meteor_interval
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
    meteor_interval = 1
    next_m = 1

    ship_locs = queue.new()
end

function spawn_meteor(point)
    local distance = 50
    local direction = rnd(1)
    local x = distance * cos(direction) + player.x
    local y = distance * sin(direction) + player.y
    local dirx = (player.x - x)/distance
    local diry = (player.y - y)/distance
    local dirAng = atan2(dirx, diry) + rnd(0.1) - 0.05
    local vx = cos(dirAng)
    local vy = sin(dirAng)
    local meteor = meteor:new({
        x = x,
        y = y,
        vx = vx,
        vy = vy
    })
    entities[#entities+1] = meteor
end
