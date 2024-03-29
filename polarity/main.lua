function _init()
    -- enable mouse
	poke(0x5f2d, 1)
    restart()
end

function _draw()
    cls()
    for i, v in pairs(state.entities) do
        v:draw()
    end
    for i, v in pairs(state.projectiles) do
        v:draw()
    end
end

function _update()
    local mouse_x = stat(32)
    local mouse_y = stat(33)

    state.mouse:move(mouse_x, mouse_y)

	state.player:control(btn(0), btn(1), btn(2), btn(3))

    if (btn(4) or btn(5)) then
        state.player:shoot(state, atan2(mouse_x - state.player.x, mouse_y - state.player.y))
    end

    ArrayRemove(state.projectiles, function(t, i, j)
        local v = t[i]
        v:update(time() - state.last)
        return v.dead ~= true
    end)

    for i, v in pairs(state.entities) do
        v:update(time() - state.last)
    end

    queue.pushright(ship_locs, {x = state.player.x - 63, y = state.player.y - 63})
    if (ship_locs.last - ship_locs.first > 20) then
        local loc = queue.popleft(ship_locs)
        camera(loc.x, loc.y)
    end

    if (flr(time()) == state.next_m) then
        spawn_meteor(state.player)
        state.next_m += state.meteor_interval
    end

    state.last = time()
end

function restart()
    cls()
    local mouse_x = stat(32)
    local mouse_y = stat(33)
    local mouse = entity:new()
    local player = ship:new({
        g = gun:new({
            projectile={

            }
        })
    })

    state = {
        last = time(),
        mouse = mouse,
        player = player,
        entities = {
            mouse,
            player
        },

        projectiles = { },
        meteor_interval = 1,
        next_m = 1,
    }


    ship_locs = queue:new()
end

function spawn_meteor(point)
    local distance = 50
    local direction = rnd(1)
    local x = distance * cos(direction) + state.player.x
    local y = distance * sin(direction) + state.player.y
    local dirx = (state.player.x - x)/distance
    local diry = (state.player.y - y)/distance
    local dirAng = atan2(dirx, diry) + rnd(0.1) - 0.05
    local vx = cos(dirAng)
    local vy = sin(dirAng)
    local meteor = meteor:new({
        x = x,
        y = y,
        vx = vx,
        vy = vy
    })
    state.entities[#state.entities+1] = meteor
end
