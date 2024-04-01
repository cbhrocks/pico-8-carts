screen_width = 128
screen_height = 128

function _init()
    -- enable mouse
	poke(0x5f2d, 1)
    restart()
end

function _draw()
    cls()
    local update_time = time()
    for i, v in pairs(state.entities) do
        v:draw()
    end
    for i, v in pairs(state.projectiles) do
        v:draw()
    end
    print("refresh rate: "..update_time-state.last_draw.."",state.camera.x, state.camera.y)
    state.last_draw = update_time
end

function _update()
    local update_time = time()
    local mouse_x = stat(32)
    local mouse_y = stat(33)

	state.player:control(btn(0), btn(1), btn(2), btn(3))

    if (btn(4) or btn(5) or (stat(34) & 0b0001) != 0) then
        state.player:shoot(state, atan2(state.mouse.x - state.player.x, state.mouse.y - state.player.y))
    end

    ArrayRemove(state.projectiles, function(t, i, j)
        local v = t[i]
        v:update(update_time - state.last_update)

        -- check if enemy hit by player bullet
        for i,e in pairs(state.entities) do
            if e.type == 'enemy' and v.type == 'player' and colliding(v,e) then
                e.dead = true
                return false
            end
        end
        return v.dead ~= true
    end)

    ArrayRemove(state.entities, function(t, i, j)
        local v = t[i]
        if (v.dead) return false
        v:update(update_time - state.last_update)
        -- check if enemy is colliding with player
        if v.type == 'enemy' then
            for i, v2 in pairs(state.entities) do
                if v2.type == 'player' and colliding(v, v2) then
                    return false
                end
            end
        end
        return true
    end)

    state.camera:move(state.player.x - screen_width/2, state.player.y - screen_height/2)
    camera(state.camera.x, state.camera.y)
    -- move mouse
    state.mouse:move(mouse_x + state.camera.x, mouse_y + state.camera.y)

    if (flr(update_time) == state.next_m) then
        spawn_meteor(state.player)
        state.next_m += state.meteor_interval
    end

    state.last_update = update_time
end

function restart()
    cls()
    local mouse_x = stat(32)
    local mouse_y = stat(33)
    local mouse = entity:new({
        type='other'
    })
    local player = ship:new({
        g = gun:new({
            projectile={

            }
        })
    })
    local camera = entity:new({
        x=63,
        y=63
    })

    state = {
        last_update = time(),
        last_draw = time(),
        mouse = mouse,
        player = player,
        camera = camera,
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
    local meteor = entity:new({
        s_id=1,
        type='enemy',
        x = x,
        y = y,
        vx = vx,
        vy = vy,
    })
    state.entities[#state.entities+1] = meteor
end
