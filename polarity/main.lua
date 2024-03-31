screen_width = 128
screen_height = 128

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
    -- ArrayRemove(state.entities, function(t, i, j)
    --     local v = t[i]
    --     if v.e_type == 'enemy' then
    --         --print('checking enemy', state.camera.x, state.camera.y)
    --         for i, v2 in pairs(state.entities) do
    --             if v2.e_type == 'player' and colliding(v, v2) then
    --                 print('colliding', state.camera.x, state.camera.y)
    --             end
    --         end
    --     end
    --     return true
    -- end)
end

function _update()
    local mouse_x = stat(32)
    local mouse_y = stat(33)


	state.player:control(btn(0), btn(1), btn(2), btn(3))

    if (btn(4) or btn(5) or (stat(34) & 0b0001) != 0) then
        state.player:shoot(state, atan2(state.mouse.x - state.player.x, state.mouse.y - state.player.y))
    end

    ArrayRemove(state.projectiles, function(t, i, j)
        local v = t[i]
        v:update(time() - state.last)
        local hit_player = colliding(v, state.player)
        return v.dead ~= true
    end)

    ArrayRemove(state.entities, function(t, i, j)
        local v = t[i]
        v:update(time() - state.last)
        if v.e_type == 'enemy' then
            for i, v2 in pairs(state.entities) do
                if v2.e_type == 'player' and colliding(v, v2) then
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
    local camera = entity:new({
        x=63,
        y=63
    })

    state = {
        last = time(),
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
    local meteor = meteor:new({
        e_type='enemy',
        x = x,
        y = y,
        vx = vx,
        vy = vy
    })
    state.entities[#state.entities+1] = meteor
end
